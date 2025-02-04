//
//  TabBarCoordinator.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit.UINavigationController

final class TabBarCoordinator: Coordinator {
        
    var parentCoordinator: Coordinator?
    var appCoordinator: AppCoordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var tabBarController = TabBarController()
    
    private var homeCoordinator: HomeCoordinator?
//    private var upcomingCoordinator: UpComingCoordinator?
//    private var searchCoordinator: SearchCooordinator?
//    private var downloadCoordinator: DownloadCoordinator?
//    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        // home
        let homeNavigation = UINavigationController()
        homeCoordinator = HomeCoordinator(navigationController: homeNavigation)
        homeCoordinator?.start()
        homeCoordinator?.parentCoordinator = parentCoordinator
        
        let homeTab = UITabBarItem()
        homeTab.title = "Home"
        homeTab.image = UIImage(systemName: "house")
        homeTab.selectedImage = UIImage(systemName: "house.fill")
        homeNavigation.tabBarItem = homeTab
        
        // search
        
        let searchNavigation = UINavigationController()
//        searchCoordinator = SearchCooordinator(navigationController: searchNavigation)
//        searchCoordinator?.start()
//        searchCoordinator?.parentCoordinator = parentCoordinator
        
        let searchTab = UITabBarItem()
        searchTab.title = "Search"
        searchTab.image = UIImage(systemName: "magnifyingglass")
        searchTab.selectedImage = UIImage(systemName: "magnifyingglass.fill")
        searchNavigation.tabBarItem = searchTab
        
        // Download
        
        let downloadNavigation = UINavigationController()
//        downloadCoordinator = DownloadCoordinator(navigationController: downloadNavigation)
//        downloadCoordinator?.start()
//        downloadCoordinator?.parentCoordinator = parentCoordinator
        
        let downloadTab = UITabBarItem()
        downloadTab.title = "Download"
        downloadTab.image = UIImage(systemName: "arrow.down.circle")
        downloadTab.selectedImage = UIImage(systemName: "arrow.down.circle.fill")
        downloadNavigation.tabBarItem = downloadTab
        
        navigationController.pushViewController(tabBarController, animated: true)
        

        parentCoordinator?.children.append(homeCoordinator ?? HomeCoordinator(navigationController: UINavigationController()))
        
//        parentCoordinator?.children.append(searchCoordinator ?? SearchCooordinator(navigationController: UINavigationController()))
//        
//        parentCoordinator?.children.append(downloadCoordinator ?? DownloadCoordinator(navigationController: UINavigationController()))
        
        tabBarController.viewControllers = [homeNavigation, searchNavigation, downloadNavigation]
    }
}
