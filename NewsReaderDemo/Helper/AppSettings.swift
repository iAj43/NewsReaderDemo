//
//  AppSettings.swift
//  NewsReaderDemo
//
//  Created by IA on 16/09/24.
//

import Foundation

let language: String = "en"

let apiToken: String = "7y9kxQzxhxKF8WSmSSzdIYzdFS7B7eNMbbjWEjFk" // replace apiToken here is call limit exceeds

let categoriesArray: [String] = [
    "Sports",
    "Business",
    "Politics",
    "Food",
    "Travel"
]

var newsCategory: String = categoriesArray.first?.lowercased() ?? ""

var selectedIndex: Int = 0
