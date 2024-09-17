//
//  AllNewsResponse.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import Foundation

struct AllNewsResponse: Decodable {
    let meta: Meta?
    let data: [NewsArticle]?
}

struct Meta: Decodable {
    let found: Int?
    let returned: Int?
    let limit: Int?
    let page: Int?
}

struct NewsArticle: Decodable {
    let uuid: String?
    let title: String?
    let description: String?
    let keywords: String?
    let snippet: String?
    let url: String?
    let imageUrl: String?
    let language: String?
    let publishedAt: String?
    let source: String?
    let categories: [String]?
    let relevanceScore: Double?
    
    private enum CodingKeys: String, CodingKey {
        case uuid, title, description, keywords, snippet, url
        case imageUrl = "image_url"
        case language, publishedAt = "published_at"
        case source, categories, relevanceScore = "relevance_score"
    }
}
