//
//  CoreAPIManager.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import Foundation
final class CoreAPIManager {
    static let instance = CoreAPIManager()
    private init() {}
    
    func request<T: Decodable>(
        type: T.Type, //response ne olacaq
        url: URL?, // url ne olacaq
        method: HttpMethods,
        header: [String: String] = [:], //header
        body: [String : Any] = [:], // body
        completion: @escaping((Result<T,CoreErrorModel>) -> Void)
    ) {
        guard let url = url else {return}
        print("URL:", url)
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = CoreAPIHelper.instance.makeHeader()
        request.httpMethod = method.rawValue
        if !body.isEmpty {
            let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = bodyData
            print("body: \(String(data: try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted), encoding: .utf8)!)")
        }
        
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {return}
            guard let response = response as? HTTPURLResponse else {return}
            if response.statusCode == 401 {
                completion(.failure(CoreErrorModel.authError(code: response.statusCode)))
            }
            
            print(response.statusCode)
            guard let error = error else {
                guard let data = data else {return}
                handleResponse(data: data, completion: completion)
                return
            }
            completion(.failure(CoreErrorModel(code: response.statusCode, message: error.localizedDescription)))
        }
        task.resume()
    }
    
    fileprivate func handleResponse<T: Decodable>( // Json'u Parse etdiyimiz function
        data: Data,
        completion: @escaping((Result<T,CoreErrorModel>) -> Void)
    ) {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            //            print("Response:",response)
            completion(.success(response))
        }
        catch {
            completion(.failure(CoreErrorModel.decodingError()))
        }
    }
}
