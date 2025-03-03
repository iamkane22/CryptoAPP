//
//  HomeVM.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import Foundation

enum MarketSortOrder: String {
    case descending
    case ascending
}

final class HomeVM {
    
    var type: MarketSortOrder = .descending {
        didSet {
            getCoinMarketData()
            getCoinSmallToBig()
        }
    }
    
    enum viewState {
    case loading
    case loaded
    case succes
    case error(String)
    }
    //CoinMarket
    private(set) var coinlist: CoinMarketDTO?
    private var coinMarketUse: CoinMarketUseCase
    private var coinMarketData: CoinMarketDTO?
    //CoinList
    private var coinListUse : CoinListUseCase
    private var coinList : CoinListDTO?
    //CoinSmallToBig
    private(set) var coinsSmallToBigList: CoinsSmallToBigDTO?
    private var coinSmallToBigUse: CoinsSmallToBigUseCase
    private var coinSmallToBigData: CoinsSmallToBigDTO?
    private(set) var filteredData: [TitleSubtitleProtocol]?
    //news
    private(set) var newsListt: NewsDTO?
    private var newsUse: NewsUseCase
    private var newsData: NewsDTO?
    var requestCallback : ((viewState) -> Void)?
    private var updateTimer: Timer?
    weak var navigation: HomeNav?
    init(navigation: HomeNav) {
        self.navigation = navigation
        coinListUse = CoinListAPIService()
        coinMarketUse = CoinMarketAPIService()
        coinSmallToBigUse = CoinsSmallToBigService()
        newsUse = NewsAPIService()
    }
   
    
    func getCoinList() {
        requestCallback?(.loading)
        coinListUse.getCoinList { [weak self] dto , error in
            guard let self = self else { return }
            requestCallback?(.loaded)
            if let dto = dto {
                coinList = dto
                requestCallback?(.succes)
            } else if let  error = error {
                requestCallback?(.error(error))
            }
        }
    }
    
    func getCoinMarketData() {
        print("Fetching coin market data...", Date())
        requestCallback?(.loading)
        coinMarketUse.getCoinMarketData { [weak self] dto, error in
            guard let self = self else { return }
            self.requestCallback?(.loaded)
            if let dto = dto {
                self.coinMarketData = dto
                self.coinlist = dto
                if self.type == .descending {
                self.filteredData = dto
                }
//                self.filteredData = dto
                self.requestCallback?(.succes)
//                print("Coin market data successfully fetched!", Date())
            } else if let error = error {
                self.requestCallback?(.error(error))
                print("Error fetching coin market data: \(error)")
            }
        }
    }
    
    func getCoinSmallToBig() {
        print("Fetching coin market data...", Date())
        requestCallback?(.loading)
        coinSmallToBigUse.getCoinsSmallToBigUse{ [weak self] dto, error in
            guard let self = self else { return }
            self.requestCallback?(.loaded)
            if let dto = dto {
                self.coinSmallToBigData = dto
                self.coinsSmallToBigList = dto
//                self.filteredData = dto
//                self.requestCallback?(.succes)
//                print("Coin market data successfully fetched!", Date())
            } else if let error = error {
                self.requestCallback?(.error(error))
                print("Error fetching coin market data: \(error)")
            }
        }
    }
    func getNews() {
        requestCallback?(.loading)
        newsUse.fetchNews{ [weak self] dto, error in
            guard let self = self else { return }
            self.requestCallback?(.loaded)
            if let dto = dto {
                self.newsData = dto
                self.newsListt = dto
                self.requestCallback?(.succes)
            } else if let error = error {
                self.requestCallback?(.error(error))
            }
        }
    }

    
    func applySort(order: MarketSortOrder) {
            switch order {
            case .descending:
                if let marketData = coinMarketData {
                    filteredData = marketData
                }
            case .ascending:
                if let smallToBigData = coinSmallToBigData {
                    filteredData = smallToBigData
                }
            }
        }
    
    func getCoins() -> Int {
            return filteredData?.count ?? 0
        }
        
    func getProtocol(item: Int) -> TitleSubtitleProtocol? {
            return filteredData?[item]
        }
    
    func getNewsList() -> Int {
        newsData?.data?.count ?? 4
    }
    
    func getNewsProtocol(item: Int) -> NewsProtocol? {
        newsData?.data?[item]
    }
    
    func showDetail(detail: DetailModel) {
        navigation?.showCryptoDetail(detail: detail)
    }
    
    func navigateDetail(for index: Int) {
            switch type {
            case .descending:
                if let coin = coinMarketData?[index] {
                    let detail = DetailModel(
                        coinID: coin.id,
                        coinName: coin.name,
                        coinPrice: String(coin.currentPrice ?? 0.0),
                        coinImageURL: coin.coinImageURL,
                        high24H: String(coin.high24H ?? 4.0),
                        low24H: String(coin.low24H ?? 0.0),
                        marketCap: coin.marketCapCoin,
                        volume: String(coin.totalVolume ?? 3.0)
                    )
                    navigation?.showCryptoDetail(detail: detail)
                }
            case .ascending:
                if let coin = coinSmallToBigData?[index] {
                    let detail = DetailModel(
                        coinID: coin.id,
                        coinName: coin.name,
                        coinPrice: String(coin.currentPrice ?? 0.0),
                        coinImageURL: coin.coinImageURL,
                        high24H: String(coin.high24H ?? 4.0),
                        low24H: String(coin.low24H ?? 0.0),
                        marketCap: coin.marketCapCoin,
                        volume: String(coin.totalVolume ?? 3.0)
                    )
                    navigation?.showCryptoDetail(detail: detail)
                }
            }
        }
}
    



