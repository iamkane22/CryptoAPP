//
//  HomeVM.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import Foundation

enum MarketSortOrder {
    case descending
    case ascending
}
final class HomeVM {
    
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
    private(set) var newsList: NewsDTO?
    private var newsUse: NewsUseCase
    private var newsData: NewsDTO?
    var requestCallback : ((viewState) -> Void)?
    private var updateTimer: Timer?
    
    init() {
        coinListUse = CoinListAPIService()
        coinMarketUse = CoinMarketAPIService()
        coinSmallToBigUse = CoinsSmallToBigService()
        newsUse = NewsAPIService()
    }
    
    func startPolling(interval: TimeInterval = 20.0) {
        print("Polling started" , Date())
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.getCoinSmallToBig()
            self?.getCoinMarketData()
        }
    }
    
    func stopPolling() {
        updateTimer?.invalidate()
        updateTimer = nil
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
                self.filteredData = dto
                self.requestCallback?(.succes)
                print("Coin market data successfully fetched!", Date())
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
                self.requestCallback?(.succes)
                print("Coin market data successfully fetched!", Date())
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
                self.newsList = dto
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
    

}

