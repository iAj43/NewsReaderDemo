//
//  NewsViewModel.swift
//  NewsReaderDemo
//
//  Created by IA on 18/09/24.
//

import Foundation

class NewsViewModel: ObservableObject {
    
    @Published var articles: [NewsArticle] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchNews() async {
        isLoading = true
        errorMessage = nil
        
        let queryParams: String = "?language=\(language)&api_token=\(apiToken)&categories=\(newsCategory)"
        
        var request = APIRequest(
            baseURL: NetworkConstants.baseURL,
            path: NetworkConstants.allNews,
            method: .GET,
            parameters: nil,
            headers: ["content-type": "application/x-www-form-urlencoded"]
        )
        request.path = request.path + queryParams
        do {
            let allNewsResponse: AllNewsResponse = try await networkManager.fetchData(request: request)
//            print(allNewsResponse.data as Any)
            DispatchQueue.main.async {
                self.articles = allNewsResponse.data ?? []
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Failed to fetch articles: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
