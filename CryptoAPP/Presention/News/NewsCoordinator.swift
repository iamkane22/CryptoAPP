//
//  NewsCoordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 06.02.25.
//

import UIKit.UINavigationController

final class NewsCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = NewsViewController(viewModel: .init())
        showController(vc: controller)
    }
}
