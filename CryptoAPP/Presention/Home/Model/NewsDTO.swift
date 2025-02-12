//
//  NewsDTO.swift
//  CryptoAPP
//
//  Created by Kenan on 12.02.25.
//

import Foundation

// MARK: - NewsItem
struct NewsItem: Codable {
    let title: String
    let url: String
    let domain: String
    let created_at: String
    let source: NewsSource
    let thumbnail: String?
}

// MARK: - NewsSource
struct NewsSource: Codable {
    let title: String
}

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let results: [NewsItem]
}

typealias NewsDTO = [NewsItem]
