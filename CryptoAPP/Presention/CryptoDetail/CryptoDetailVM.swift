//
//  CryptoDetailVM.swift
//  CryptoAPP
//
//  Created by Kenan on 19.02.25.
//

import Foundation

final class CryptoDetailVM {
    enum ViewState {
        case loading
        case loaded
        case success
        case error
    }
    
    let model: DetailModel
    
    private weak var navigation: HomeNav?
    var requestCallback: ((ViewState) -> Void)?
    
    init(navigation: HomeNav, model: DetailModel) {
        self.navigation = navigation
        self.model = model
    }
    
    func fetchData() {
        requestCallback?(.loading)
        
        // İmitasiya üçün
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            let isSuccess = Bool.random()
            DispatchQueue.main.async {
                self.requestCallback?(isSuccess ? .success : .error)
            }
        }
    }
}
