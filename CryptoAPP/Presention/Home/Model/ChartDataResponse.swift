//
//  ChartDataResponse.swift
//  CryptoAPP
//
//  Created by Kenan on 24.02.25.
//

import Foundation

struct ChartDataResponse: Decodable {
    let prices: [[Double]]
}
