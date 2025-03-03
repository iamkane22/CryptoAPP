//
//  ChartAPIService.swift
//  CryptoAPP
//
//  Created by Kenan on 24.02.25.
//

import DGCharts
import Foundation

final class ChartAPIService: ChartUseCase {
    
    private let apiService = CoreAPIManager.instance
    
    func fetchChartData(for coinID: String, days: Int, completion: @escaping ([ChartDataEntry]?, String?) -> Void) {
        guard let url = ChartAPIHelper.endpoint(coinID: coinID, days: days) else {
            completion(nil, "Invalid URL")
            return
        }
        
        apiService.request(type: ChartDataResponse.self, url: url, method: .GET) { result in
            switch result {
            case .success(let data):
                let entries = data.prices.map { item -> ChartDataEntry in
                    let timestamp = item[0] / 1000
                    let price = item[1]
                    return ChartDataEntry(x: timestamp, y: price)
                }
                completion(entries, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
