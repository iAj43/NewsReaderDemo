//
//  NetworkManager.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    // MARK: - fetchData from server using URLSession
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T {
        let (data, response) = try await getRequestData(request: request)
        return try await handleResponse(data: data, response: response, mappingClass: T.self)
    }
}

private extension NetworkManager {
    
    // MARK: - Get Data from URLSession
    private func getRequestData(request: APIRequest) async throws -> (Data, URLResponse) {
        guard let url = URL(string: request.baseURL + request.path) else {
            throw URLError(.badURL) // Handle invalid URL case
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
//        urlRequest.debug()
        // Set request body if needed
        if let parameters = request.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        // Perform the network request
        return try await URLSession.shared.data(for: urlRequest)
    }
    
    // MARK: - Handle server response using JSONDecoder
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse, mappingClass: T.Type) async throws -> T {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ErrorHandler.generalError
        }
        do {
            let decodedObj = try JSONDecoder().decode(T.self, from: data)
            return decodedObj
        } catch {
            // Try to decode the error model for more specific error handling
            do {
                let errorModel = try JSONDecoder().decode(ErrorModel.self, from: data)
                throw ErrorHandler.custom(errorModel.error?.message ?? "")
            } catch {
                throw ErrorHandler.generalError
            }
        }
    }
}
