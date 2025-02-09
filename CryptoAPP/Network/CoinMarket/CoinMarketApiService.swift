//
//  CoinMarketApiService.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

final class CoinMarketAPIService: CoinMarketUseCase {
    private let apiService = CoreAPIManager.instance
    
    func getCoinMarketData(completion: @escaping (CoinMarketDTO?, String?) -> Void) {
        apiService.request(type: CoinMarketDTO.self, url: CoinMarketHelper.market.endpoint, method: .GET) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(let data):
                completion(data, "")
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
