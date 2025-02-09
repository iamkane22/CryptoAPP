//
//  MarketCoordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 05.02.25.
//

import UIKit.UINavigationController

final class MarketCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = MarketController(viewModel: .init())
        showController(vc: controller)
    }
}
