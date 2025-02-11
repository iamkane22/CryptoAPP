//
//  CoreAPIHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

protocol CoinMarketUseCase {
    func getCoinMarketData(completion: @escaping (CoinMarketDTO?, String?) -> Void)
}
