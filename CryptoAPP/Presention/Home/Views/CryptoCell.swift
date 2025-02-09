//
//  CryptoCell.swift
//  CryptoAPP
//
//  Created by Kenan on 09.02.25.
//

import UIKit

protocol CryptoCellProtocol {
    var iconString: String { get }
    var nameString: String { get }
    var valueString: String { get }
    var changeString: String { get }
    var marketCapString: String { get }
}
class CryptoCell: UICollectionViewCell {

    // UI Elementlər
    let coinIconImageView = UIImageView()
    let coinNameLabel = UILabel()
    let coinValueLabel = UILabel()
    let coinChangeLabel = UILabel()
    let marketCapLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Hücrə stilini qururuq
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        
        // İkon ImageView
        coinIconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(coinIconImageView)
        
        // Coin Adı Label
        coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coinNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(coinNameLabel)
        
        // Coin Dəyəri Label
        coinValueLabel.translatesAutoresizingMaskIntoConstraints = false
        coinValueLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(coinValueLabel)
        
        // Coin Dəyişiklik (24h) Label
        coinChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        coinChangeLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(coinChangeLabel)
        
        // Market Cap Label
        marketCapLabel.translatesAutoresizingMaskIntoConstraints = false
        marketCapLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(marketCapLabel)
        
        // Auto Layout constraints
        NSLayoutConstraint.activate([
            coinIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            coinIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinIconImageView.widthAnchor.constraint(equalToConstant: 40),
            coinIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            coinNameLabel.leadingAnchor.constraint(equalTo: coinIconImageView.trailingAnchor, constant: 10),
            coinNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            coinValueLabel.leadingAnchor.constraint(equalTo: coinIconImageView.trailingAnchor, constant: 10),
            coinValueLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 5),
            coinValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            coinChangeLabel.leadingAnchor.constraint(equalTo: coinIconImageView.trailingAnchor, constant: 10),
            coinChangeLabel.topAnchor.constraint(equalTo: coinValueLabel.bottomAnchor, constant: 5),
            coinChangeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            marketCapLabel.leadingAnchor.constraint(equalTo: coinIconImageView.trailingAnchor, constant: 10),
            marketCapLabel.topAnchor.constraint(equalTo: coinChangeLabel.bottomAnchor, constant: 5),
            marketCapLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            marketCapLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: CryptoCellProtocol) {
        coinIconImageView.image = UIImage(named: coin.iconString)
        coinNameLabel.text = coin.nameString
        coinValueLabel.text = "$\(coin.valueString)"
        
        if let change = Double(coin.changeString) {
            coinChangeLabel.text = "\(change)%"
            coinChangeLabel.textColor = change > 0 ? .green : .red
        } else {
            coinChangeLabel.text = "N/A"
            coinChangeLabel.textColor = .gray
        }
        marketCapLabel.text = "Market Cap: $\(coin.marketCapString)"
    }
}
