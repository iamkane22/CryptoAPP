//
//  CrytoDetailVC.swift
//  CryptoAPP
//
//  Created by Kenan on 19.02.25.
//

import UIKit
import DGCharts

final class CrytoDetailVC: BaseVC {
    
    // MARK: - Properties
    private let viewModel: CryptoDetailVM
    private let chartService = ChartAPIService()
    
    // MARK: - UI Elements
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let contentView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let coinImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 40
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeIntervalSegmentedControl: UISegmentedControl = {
        let items = ["1D", "7D", "30D", "1Y"]
        let segControl = UISegmentedControl(items: items)
        segControl.selectedSegmentIndex = 0
        segControl.translatesAutoresizingMaskIntoConstraints = false
        
        segControl.selectedSegmentTintColor = .systemBlue
        segControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        return segControl
    }()
    
    private let chartView: LineChartView = {
        let chart = LineChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.noDataText = "No chart data available"
        chart.chartDescription.enabled = false
        chart.legend.enabled = false
        chart.rightAxis.enabled = false
        chart.xAxis.labelPosition = .bottom
        
        // Daha az label
        chart.xAxis.labelCount = 4
        chart.xAxis.granularity = 1
        chart.xAxis.avoidFirstLastClippingEnabled = true
        
        // Y-oxu dəyərlər
        let leftAxis = chart.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(decimals: 4)
        
        return chart
    }()
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let highLabel: UILabel = {
        let label = UILabel()
        label.text = "24H High: -"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let lowLabel: UILabel = {
        let label = UILabel()
        label.text = "24H Low: -"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Cap: -"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = "Volume: -"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .systemBlue
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Init
    init(viewModel: CryptoDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        timeIntervalSegmentedControl.addTarget(self, action: #selector(timeIntervalChanged(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configureUI()
        
        activityIndicator.startAnimating()
        fetchData(for: 1) // Başlanğıc olaraq 1D
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [coinImageView, coinNameLabel, coinPriceLabel,
         timeIntervalSegmentedControl, chartView, statsStackView,
         activityIndicator
        ].forEach { contentView.addSubview($0) }
        
        [highLabel, lowLabel, marketCapLabel, volumeLabel].forEach {
            statsStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            coinImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 80),
            coinImageView.heightAnchor.constraint(equalToConstant: 80),
            
            coinNameLabel.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 8),
            coinNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            coinPriceLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 8),
            coinPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            coinPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            timeIntervalSegmentedControl.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor, constant: 16),
            timeIntervalSegmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            chartView.topAnchor.constraint(equalTo: timeIntervalSegmentedControl.bottomAnchor, constant: 16),
            chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chartView.heightAnchor.constraint(equalToConstant: 300),
            
            statsStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: chartView.centerYAnchor),
            
            statsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        let coinName = viewModel.model.coinName ?? "No Name"
        let coinPrice = viewModel.model.coinPrice ?? "0.0"
        let coinHigh = viewModel.model.high24H ?? "0"
        let coinLow = viewModel.model.low24H ?? "0"
        let coinMarketCap = viewModel.model.marketCap ?? "0"
        let coinVolume = viewModel.model.volume ?? "0"
        
        coinNameLabel.text = coinName.isEmpty ? "No Name" : coinName
        coinPriceLabel.text = "\(coinPrice) $"
        highLabel.text = "24H High: \(coinHigh)"
        lowLabel.text = "24H Low: \(coinLow)"
        marketCapLabel.text = "Market Cap: \(coinMarketCap)"
        volumeLabel.text = "Volume: \(coinVolume)"
        
        // Coin şəkil yükləmə (istəyə bağlı)
        if let coinImageURL = viewModel.model.coinImageURL,
           !coinImageURL.isEmpty,
           let url = URL(string: coinImageURL) {
            // Məsələn, SDWebImage:
            // coinImageView.sd_setImage(with: url)
        }
    }
    
    // MARK: - Fetch Data (Real Chart Məlumatı)
    private func fetchData(for days: Int) {
        guard let coinID = viewModel.model.coinID, !coinID.isEmpty else {
            activityIndicator.stopAnimating()
            return
        }
        
        chartService.fetchChartData(for: coinID, days: days) { [weak self] entries, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                print("Chart data error:" )
                return
            }
            guard let entries = entries, !entries.isEmpty else {
                print("No chart data available")
                return
            }
            DispatchQueue.main.async {
                self.updateChart(entries)
            }
        }
    }
    
    // MARK: - Update Chart
    private func updateChart(_ entries: [ChartDataEntry]) {
        // Tarix formatı
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        chartView.xAxis.valueFormatter = DateValueFormatter(dateFormatter: dateFormatter)
        
        // Marker (tooltip)
        let marker = ChartMarker(dateFormatter: dateFormatter)
        marker.chartView = chartView
        chartView.marker = marker
        
        let labelText = "\(viewModel.model.coinName ?? "") Price"
        let dataSet = LineChartDataSet(entries: entries, label: labelText)
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.setColor(.systemBlue)
        dataSet.drawValuesEnabled = false
        
        // Gradient fill
        let gradientColors = [
            UIColor.systemBlue.withAlphaComponent(0.3).cgColor,
            UIColor.clear.cgColor
        ] as CFArray
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                     colors: gradientColors,
                                     locations: colorLocations) {
            dataSet.fill = LinearGradientFill(gradient: gradient, angle: 90.0)
            dataSet.drawFilledEnabled = true
        }
        
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
        
        // Qrafik min/max-i data-ya uyğunlaşdır
        if let minEntry = entries.min(by: { $0.y < $1.y }),
           let maxEntry = entries.max(by: { $0.y < $1.y }) {
            
            let range = maxEntry.y - minEntry.y
            let padding = range * 0.1
            let leftAxis = chartView.leftAxis
            leftAxis.axisMinimum = minEntry.y - padding
            leftAxis.axisMaximum = maxEntry.y + padding
        }
        
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }
    
    // MARK: - Actions
    @objc private func timeIntervalChanged(_ sender: UISegmentedControl) {
        let days: Int
        switch sender.selectedSegmentIndex {
        case 0: days = 1
        case 1: days = 7
        case 2: days = 30
        case 3: days = 365
        default: days = 1
        }
        activityIndicator.startAnimating()
        fetchData(for: days)
    }
}
