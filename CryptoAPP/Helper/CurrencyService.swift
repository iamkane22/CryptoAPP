import Foundation

final class CurrencyService {
    private let apiManager = CoreAPIManager.instance
    
    func fetchRates(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        guard let url = URL(string: "https://api.binance.com/api/v3/ticker/price") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400)))
            return
        }
        
        apiManager.request(type: [[String: String]].self, url: url, method: .GET) { result in
            switch result {
            case .success(let data):
                var rates: [String: Double] = [:]
                for item in data {
                    if let symbol = item["symbol"], let price = item["price"], let priceDouble = Double(price) {
                        rates[symbol] = priceDouble
                    }
                }
                completion(.success(rates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
