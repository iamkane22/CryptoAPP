//
//  ChartMarker.swift
//  CryptoAPP
//
//  Created by Kenan on 02.03.25.
//

import DGCharts
import UIKit

class ChartMarker: MarkerView {
    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = .white
        lbl.backgroundColor = .darkGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let dateFormatter: DateFormatter
    
    init(dateFormatter: DateFormatter) {
        self.dateFormatter = dateFormatter
        super.init(frame: .zero)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let date = Date(timeIntervalSince1970: entry.x)
        let dateString = dateFormatter.string(from: date)
        let priceString = String(format: "%.4f", entry.y)
        textLabel.text = "\(dateString)\n$\(priceString)"
        layoutIfNeeded()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        self.frame = CGRect(x: point.x - self.frame.width / 2,
                            y: point.y - self.frame.height - 10,
                            width: 80,
                            height: 40)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds
    }
}
