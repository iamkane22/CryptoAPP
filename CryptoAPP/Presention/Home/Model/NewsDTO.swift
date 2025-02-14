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

extension NewsItem: NewsProtocol {
    var thumbnailimage: String {
        thumbnail ?? ""
    }
    
    var titleNews: String {
        title
    }
    
    var domainNews: String {
        domain
    }
    
    var dateNews: String {
        created_at
    }
    
    var sourceNews: String {
        return ""
    }
    
    
}


// MARK: - NewsResponse
struct NewsResponse: Codable {
    let results: [NewsItem]
}

typealias NewsDTO = [NewsItem]

