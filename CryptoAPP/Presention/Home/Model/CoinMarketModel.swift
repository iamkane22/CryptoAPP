//
//  CoinMarketModel.swift
//  CryptoAPP
//
//  Created by Kenan on 08.02.25.
//

import Foundation

struct CoinMarketDTOElement: Codable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Int?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply, totalSupply: Double?
    let maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    let priceChangePercentage1HInCurrency, priceChangePercentage24HInCurrency, priceChangePercentage7DInCurrency: Double?

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
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage7DInCurrency = "price_change_percentage_7d_in_currency"
    }
}
extension CoinMarketDTOElement: TitleSubtitleProtocol {
    var nameCoin: String {
        name ?? "not info"
    }
    
    var valueCoin: String {
        String(format: "%.2f $", currentPrice ?? 0.0)
    }
    
    var changeCoin: String {
        return String(format: "%.2f%%", priceChangePercentage24H ?? 0.0)
    }
    
    var marketCapCoin: String {
        return String(format: "%.0f $", Double(marketCap ?? 0))

    }
    
    var coinImageURL: String? {
        image ?? nil
    }
}


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
