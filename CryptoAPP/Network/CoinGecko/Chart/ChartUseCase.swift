//
//  ChartUseCase.swift
//  CryptoAPP
//
//  Created by Kenan on 24.02.25.
//
import DGCharts

protocol ChartUseCase {
    func fetchChartData(for coinID: String, days: Int, completion: @escaping ([ChartDataEntry]?, String?) -> Void)
}
