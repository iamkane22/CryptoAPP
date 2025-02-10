//
//  CoinMarketHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

enum CoinMarketHelper {
    case market
    
    var endpoint: URL? {
        return CoreAPIHelper.instance.makeURL(path: "coins/markets?vs_currency=usd&order=volume_asc&per_page=100&page=1&sparkline=false&price_change_percentage=1h,24h,7d")
    }
}
