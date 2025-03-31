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
    private var newsCoordinator: NewsCoordinator?
    private var marketcoordinator: FavouriteCoordinator?
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
        
        let homeTab = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeTab.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        homeNavigation.tabBarItem = homeTab
        
        // market
        
        let marketNavigation = UINavigationController()
        marketcoordinator = FavouriteCoordinator(navigationController: marketNavigation)
        marketcoordinator?.start()
        marketcoordinator?.parentCoordinator = parentCoordinator
        
        let marketTab = UITabBarItem()
        marketTab.title = "Market"
        marketTab.image = UIImage(systemName: "chart.bar")
        marketTab.selectedImage = UIImage(systemName: "chart.bar.fill")
        marketNavigation.tabBarItem = marketTab
        
        // news
        
        let newsNavigation = UINavigationController()
        newsCoordinator = NewsCoordinator(navigationController: newsNavigation)
        newsCoordinator?.start()
        newsCoordinator?.parentCoordinator = parentCoordinator
        
        let newsTab = UITabBarItem()
        newsTab.title = "CoinNews"
        newsTab.image = UIImage(systemName: "newspaper")
        newsTab.selectedImage = UIImage(systemName: "newspaper.fill")
        newsNavigation.tabBarItem = newsTab
        
        navigationController.pushViewController(tabBarController, animated: true)
        
        
        parentCoordinator?.children.append(homeCoordinator ?? HomeCoordinator(navigationController: UINavigationController()))
        
        parentCoordinator?.children.append(marketcoordinator ?? FavouriteCoordinator(navigationController: UINavigationController()))
        
        parentCoordinator?.children.append(newsCoordinator ?? NewsCoordinator(navigationController: UINavigationController()))
        
        tabBarController.viewControllers = [homeNavigation, marketNavigation, newsNavigation]
    }
}
