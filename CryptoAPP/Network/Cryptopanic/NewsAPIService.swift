//
//  NewsAPIService.swift
//  CryptoAPP
//
//  Created by Kenan on 12.02.25.
//

final class NewsAPIService: NewsUseCase {
    private let apiService =  CoreAPIManager.instance
    func fetchNews(completion: @escaping (NewsDTO?, String?) -> Void) {
        apiService.request(type: NewsResponse.self, url: NewsListAPIHelper.news.endpoint, method: .GET) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completion(response.results , nil)
            case .failure(let error):
                completion(nil , error.localizedDescription)
            }
        }
    }
    
    
}
