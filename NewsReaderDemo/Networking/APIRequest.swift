//
//  APIRequest.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import Foundation

struct APIRequest {
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var parameters: [String: Any]?
    var headers: [String: String]?
    
    enum HTTPMethod: String {
        case GET
        case POST
        // Add other methods if needed
    }
}
