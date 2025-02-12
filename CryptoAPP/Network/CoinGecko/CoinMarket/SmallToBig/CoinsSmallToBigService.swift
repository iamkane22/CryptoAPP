//
//  CoinsSmallToBigService.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

final class CoinsSmallToBigService: CoinsSmallToBigUseCase {
    private let apiService = CoreAPIManager.instance
    
    func getCoinsSmallToBigUse(completion: @escaping (CoinsSmallToBigDTO?, String?) -> Void) {
        apiService.request(type: CoinsSmallToBigDTO.self, url: CoinsSmallToBigHelper.market.endpoint, method: .GET) { [weak self] result in
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
