//
//  CryptoCell.swift
//  CryptoAPP
//
//  Created by Kenan on 10.02.25.
//
import UIKit

final class CryptoCell: UITableViewCell {

    let coinIconImageView = UIImageView()
    let coinNameLabel = UILabel()
    let coinValueLabel = UILabel()
    let coinChangeLabel = UILabel()
    let marketCapLabel = UILabel()
    
    fileprivate func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        coinIconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinIconImageView)
        
        coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coinNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.addSubview(coinNameLabel)
        
        coinValueLabel.translatesAutoresizingMaskIntoConstraints = false
        coinValueLabel.font = UIFont.systemFont(ofSize: 11)
        coinValueLabel.textAlignment = .right
        contentView.addSubview(coinValueLabel)
        
        coinChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        coinChangeLabel.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(coinChangeLabel)
        
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.font = UIFont.systemFont(ofSize: 8)
        contentView.addSubview(marketCapLabel)
        
        NSLayoutConstraint.activate([
            // Icon constraints
            coinIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            coinIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            coinIconImageView.widthAnchor.constraint(equalToConstant: 22),
            coinIconImageView.heightAnchor.constraint(equalToConstant: 22),
            
            // Coin name label: left of coinValueLabel
            coinNameLabel.leadingAnchor.constraint(equalTo: coinIconImageView.trailingAnchor, constant: 8),
            coinNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            coinNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: coinValueLabel.leadingAnchor, constant: -8),
            
            // Coin value label: align to right side, top aligned with coinNameLabel
            coinValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            coinValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            // Optional: Set a content hugging priority so it resists expansion
//            coinValueLabel.setContentHuggingPriority(.required, for: .horizontal),
            
            // Coin change label: below coinNameLabel, full width
            coinChangeLabel.leadingAnchor.constraint(equalTo: coinNameLabel.leadingAnchor),
            coinChangeLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 2),
            coinChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            // Market cap label: below coinChangeLabel, full width
            marketCapLabel.leadingAnchor.constraint(equalTo: coinNameLabel.leadingAnchor),
            marketCapLabel.topAnchor.constraint(equalTo: coinChangeLabel.bottomAnchor, constant: 2),
            marketCapLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            marketCapLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(coin: TitleSubtitleProtocol) {
        coinIconImageView.loadImageURL(url: coin.coinImageURL)
        coinNameLabel.text = coin.nameCoin
        coinValueLabel.text = "$\(coin.valueCoin)"
        
        if let change = Double(coin.changeCoin) {
            coinChangeLabel.text = "\(change)%"
            coinChangeLabel.textColor = change > 0 ? .green : .red
        } else {
            coinChangeLabel.text = "N/A"
            coinChangeLabel.textColor = .darkGray
        }
        marketCapLabel.text = "Market Cap: $\(coin.marketCapCoin)"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}
