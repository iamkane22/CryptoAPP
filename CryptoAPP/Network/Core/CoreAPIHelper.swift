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
    case tmdb = "https://api.themoviedb.org/3/"
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    private let baseURL = BaseURL.tmdb.rawValue
    
    func makeURL(path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
    
    
    func makeHeader() -> [String: String] {
        return [ "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYTY2MzU0ODBkMDNjNDExMzA2MzUwZDViZDM0YTdkYiIsIm5iZiI6MTczNDYzNzkzNy4zMTcsInN1YiI6IjY3NjQ3OTcxMjljODgyOTdhMTFmNjc3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rl6HikoLc4mOcMFRmaGxqhvTyxLmLMZxPxFCae2hrNQ"]
    }
}
