//
//  ChartAPIHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 24.02.25.
//

import Foundation

enum ChartAPIHelper {
    case chart
    
    static func endpoint(coinID: String, days: Int) -> URL? {
        let path = "coins/\(coinID)/market_chart?vs_currency=usd&days=\(days)"
        return CoreAPIHelper.instance.makeURL(path: path)
    }
}
