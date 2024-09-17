//
//  NetworkConstants.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import Foundation

enum NetworkConstants {
    private static var appEnvironment: Environment = .staging
    static let baseURL = appEnvironment.baseURL
    static let allNews = "/news/all"
}

enum Environment {
    case staging
    case production
    var baseURL: String {
        switch self {
        case .staging:
            return "https://api.thenewsapi.com/v1" // add staging URL here
        case .production:
            return "https://api.thenewsapi.com/v1" // add production URL here
        }
    }
}
