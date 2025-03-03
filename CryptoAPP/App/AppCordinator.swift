//
//  AppCordinator.swift
//  MovieApp
//
//  Created by Kenan on 21.12.24.
//

import UIKit

class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var window: UIWindow?
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var isLogin: Bool = true
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isLogin {
            showTabBar()
        } else {
            showAuth()
        }
    }
    
    private func setubTabBarController() {
        let tabBarController = TabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
//    func goToSearch() {
//        let vc = SearchController()
//        vc.coordinator = self
//        navigationController.show(vc, sender: nil)
//    }
    
//    func Download() {
//        let vc = DownloadController()
//        vc.coordinator = self
//        navigationController.show(vc, sender: nil)
//    }
//    
//    func Upcoming() {
//        let vc = UpComingController()
//        vc.coordinator = self
//        navigationController.show(vc, sender: nil)
//    }
    
    func showTabBar() {
        children.removeAll()
        let coordinator = TabBarCoordinator(navigationController: navigationController)
        children.append(coordinator)
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    fileprivate func showAuth() {
        children.removeAll()
        let authCoordinator = AuthCordinator(navigationController: navigationController)
        children.append(authCoordinator)
        authCoordinator.parentCoordinator = self
        authCoordinator.start()
    }
}
