//
//  Errors.swift
//  NewsReaderDemo
//
//  Created by IA on 17/09/24.
//

import Foundation

enum ErrorHandler: Error {
    case generalError
    case custom(String)
}

struct ErrorModel: Decodable {
    let error: ErrorDetails?
}
struct ErrorDetails: Decodable {
    let code: String?
    let message: String?
}
