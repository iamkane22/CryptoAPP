//
//  NewsUseCase.swift
//  CryptoAPP
//
//  Created by Kenan on 12.02.25.
//

protocol NewsUseCase {
    func fetchNews(completion: @escaping (NewsDTO?, String?) -> Void)
}
