//
//  DateValueFormatter.swift
//  CryptoAPP
//
//  Created by Kenan on 02.03.25.
//

import DGCharts
import Foundation

class DateValueFormatter: IndexAxisValueFormatter {
    private let dateFormatter: DateFormatter
    
    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
        super.init()
    }
    
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date)
    }
}
