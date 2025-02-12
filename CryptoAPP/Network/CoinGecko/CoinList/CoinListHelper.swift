//
//  CoinListHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 07.02.25.
//
import Foundation

enum CoinListHelper {
    case list
    
    var endpoint: URL? {
        return CoreAPIHelper.instance.makeURL(path: "coins/list")
    }
}

//https://api.coingecko.com/api/v3/coins/list
