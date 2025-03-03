//
//  HomeCoordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit.UINavigationController

final class HomeCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = HomeController(viewModel: .init(navigation: self))
        showController(vc: controller)
    }
}
extension HomeCoordinator: HomeNav {
    func showCryptoDetail(detail: DetailModel) {
        let detailVM = CryptoDetailVM(navigation: self, model: detail)
        let controller = CrytoDetailVC(viewModel: detailVM)
        navigationController.pushViewController(controller, animated: true)
    }
}
