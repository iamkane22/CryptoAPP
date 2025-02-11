//
//  CoinsSmallToBigUseCase.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

protocol CoinsSmallToBigUseCase {
    func getCoinsSmallToBigUse(completion: @escaping (CoinsSmallToBigDTO?, String?) -> Void)
}
