//
//  HomeVM.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import Foundation

final class HomeVM {
    
    enum viewState {
    case loading
    case loaded
    case succes
    case error(String)
    }
    private(set) var coinlist: CoinMarketDTO?
    private(set) var coinsSmallToBigList: CoinsSmallToBigDTO?
    private var coinListUse : CoinListUseCase
    private var coinList : CoinListDTO?
    private var coinMarketUse: CoinMarketUseCase
    private var coinSmallToBigUse: CoinsSmallToBigUseCase
    private var coinMarketData: CoinMarketDTO?
    private var coinSmallToBigData: CoinsSmallToBigDTO?
    var requestCallback : ((viewState) -> Void)?
    private var updateTimer: Timer?
    
    init() {
        coinListUse = CoinListAPIService()
        coinMarketUse = CoinMarketAPIService()
        coinSmallToBigUse = CoinsSmallToBigService()
    }
    
    func startPolling(interval: TimeInterval = 15.0) {
        print("Polling started" , Date())
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
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
    
    func getCoins() -> Int {
        coinlist?.count ?? 0
    }
    func getProtocol(item: Int) -> TitleSubtitleProtocol? {
        return coinlist?[item]
    }
    
    func getSmallToBigCoins() -> Int {
        coinsSmallToBigList?.count ?? 0
    }
    
//    func getSmallToBigProtocol(item: Int) -> TitleSubtitleProtocol? {
//        return coinsSmallToBigList?[item]
//    }

}

