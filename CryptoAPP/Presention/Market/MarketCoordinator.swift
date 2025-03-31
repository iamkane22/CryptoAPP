//
//  MarketCoordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 05.02.25.
//

import UIKit.UINavigationController

final class FavouriteCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = CurrencyController(viewModel: .init())
        showController(vc: controller)
    }
}
