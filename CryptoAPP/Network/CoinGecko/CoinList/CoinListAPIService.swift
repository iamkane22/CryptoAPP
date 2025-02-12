//
//  CoinListAPIService.swift
//  CryptoAPP
//
//  Created by Kenan on 07.02.25.
//
final class CoinListAPIService: CoinListUseCase {
    private let apiService = CoreAPIManager.instance
    
    func getCoinList(completion: @escaping (CoinListDTO?, String?) -> Void) {
        apiService.request(type: CoinListDTO.self, url: CoinListHelper.list.endpoint, method: .GET) { [weak self] result in
            guard let _ = self else {return}
            switch result {
            case .success(let data):
                completion(data , "")
            case .failure(let error):
                completion(nil , error.localizedDescription )
            }
        }
    }
    
}
