//
//  CoinListModel.swift
//  CryptoAPP
//
//  Created by Kenan on 07.02.25.
//

import Foundation

struct CoinListDTOElement: Codable {
    let id, symbol, name: String?
}

typealias CoinListDTO = [CoinListDTOElement]
