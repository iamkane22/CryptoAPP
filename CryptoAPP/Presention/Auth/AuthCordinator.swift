//
//  AuthCordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 27.02.25.
//

import UIKit.UINavigationController

final class AuthCordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = LoginController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
}
extension AuthCordinator: AuthNav {
    func showAuth() {
        let signUpVC = SignUpVC(viewModel: .init(navigation: self))
        navigationController.pushViewController(signUpVC, animated: true)
    }
    func showHome() {
        children.removeAll()
        let tabbar = TabBarCoordinator(navigationController: navigationController)
        children.append(tabbar)
        tabbar.parentCoordinator = self
        tabbar.start()
    }
}
