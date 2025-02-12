//
//  CoinListUseCase.swift
//  CryptoAPP
//
//  Created by Kenan on 07.02.25.
//

protocol CoinListUseCase {
    func getCoinList(completion: @escaping (CoinListDTO? , String?) -> Void)
}
