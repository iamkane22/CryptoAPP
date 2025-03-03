//
//  LoginViewModel.swift
//  CryptoAPP
//
//  Created by Kenan on 27.02.25.
//

import Foundation
import FirebaseAuth


final class LoginViewModel: ValidationProviding {
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
     weak var navigation: AuthNav?
    var requestCallBack: ((ViewState) -> Void)?
    
    init(navigation: AuthNav) {
        self.navigation = navigation
    }
    
    func login(email: String, password: String) {
        guard isValidEmail(email) else {
            requestCallBack?(.error("Email formatı yanlışdır."))
            return
        }
        
        guard isValidPassword(password) else {
            requestCallBack?(.error("Şifrə ən az 8 simvol, böyük və kiçik hərf, rəqəm və xüsusi simvol içerməlidir."))
            return
        }
        
        requestCallBack?(.loading)
        AuthManager.shared.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Giriş olundu: \(user.email ?? "Email yoxdur")")
                    self?.requestCallBack?(.success)
                    self?.navigation?.showHome()
                case .failure(let error):
                    self?.requestCallBack?(.error(error.localizedDescription))
                }
            }
        }
    }
}
