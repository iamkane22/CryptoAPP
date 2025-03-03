//
//  CoreAPIHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import Foundation
enum HttpMethods: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}


enum BaseURL: String {
    case coingecko = "https://api.coingecko.com/api/v3/"
    case cryptopanic = "https://min-api.cryptocompare.com/data/v2/"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    private let baseURL = BaseURL.coingecko.rawValue
    private let baseURLNews = BaseURL.cryptopanic.rawValue
    
    func makeURL(path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
    func makeURL2(path: String) -> URL? {
        let urlString = baseURLNews + path
        return URL(string:urlString)
    }
    
    
    func makeHeader() -> [String: String] {
        return [:]
    }
}
