//
//  SignUpViewModel.swift
//  CryptoAPP
//
//  Created by Kenan on 01.03.25.
//

import Foundation
import FirebaseAuth

final class SignUpViewModel: ValidationProviding {
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    private weak var navigation: AuthNav?
    var requestCallBack: ((ViewState) -> Void)?
    
    init(navigation: AuthNav) {
        self.navigation = navigation
    }
    
    func signUp(email: String, password: String) {
        guard isValidEmail(email) else {
            requestCallBack?(.error("Email formatı yanlışdır."))
            return
        }
        
        guard isValidPassword(password) else {
            requestCallBack?(.error("Şifrə ən az 8 simvol, böyük və kiçik hərf, rəqəm və xüsusi simvol içerməlidir."))
            return
        }
        
        requestCallBack?(.loading)
        AuthManager.shared.registerUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Qeydiyyat uğurlu: \(user.email ?? "Email yoxdur")")
                    self?.requestCallBack?(.success)
                    self?.navigation?.showHome()
                case .failure(let error):
                    self?.requestCallBack?(.error(error.localizedDescription))
                }
            }
        }
    }
}
