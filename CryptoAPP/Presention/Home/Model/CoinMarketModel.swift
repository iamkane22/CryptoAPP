//
//  CoinMarketModel.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let coinMarketDTO = try? JSONDecoder().decode(CoinMarketDTO.self, from: jsonData)

import Foundation

// MARK: - CoinMarketDTOElement
struct CoinMarketDTOElement: Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap, marketCapRank, fullyDilutedValuation: Int?
    let totalVolume, high24H, low24H, priceChange24H: Double?
    let priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H, circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    let priceChangePercentage1HInCurrency: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case priceChangePercentage1HInCurrency = "price_change_percentage_1h_in_currency"
    }
}

// MARK: - Roi
struct Roi: Codable {
    let times: Double?
    let currency: Currency?
    let percentage: Double?
}

enum Currency: String, Codable {
    case btc = "btc"
    case eth = "eth"
    case usd = "usd"
}

typealias CoinMarketDTO = [CoinMarketDTOElement]



extension CoinMarketDTOElement: TitleSubtitleProtocol {
    var coinImageURL: String {
        image ?? ""
    }
    
    var nameCoin: String {
        name ?? "not info"
    }
    
    var valueCoin: String {
        String(format: "%.2f $", currentPrice ?? 0.0)
    }
    
    var changeCoin: String {
        return String(priceChangePercentage24H ?? 0.0)
    }
    
    var marketCapCoin: String {
        return String(format: "%.0f $", Double(marketCap ?? 0))
        
    }
}
