//
//  FavouriteVM.swift
//  CryptoAPP
//
//  Created by Kenan on 05.02.25.
//

final class CurrencyVM {
    private let currencyService = CurrencyService()
    private var rates: [String: Double] = [:]
    
    func fetchRates(completion: @escaping () -> Void) {
        currencyService.fetchRates { [weak self] result in
            switch result {
            case .success(let fetchedRates):
                self?.rates = fetchedRates
                completion()
            case .failure(let error):
                print("Error fetching rates: \(error)")
            }
        }
    }
    
    func convert(amount: Double, fromCurrency: String, toCurrency: String, completion: @escaping (String) -> Void) {
        fetchRates { [weak self] in
            guard let self = self else { return }
            let fromKey = "\(fromCurrency)USDT"
            let toKey = "\(toCurrency)USDT"
            
            if let fromRate = self.rates[fromKey], let toRate = self.rates[toKey] {
                let result = (amount * fromRate) / toRate
                completion("Nəticə: \(result) \(toCurrency)")
            } else {
                completion("Məzənnə tapılmadı")
            }
        }
    }
}
