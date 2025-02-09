//
//  TabBarController.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let customTabBarView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
        self.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = customTabBarView.frame
        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
    }
    
    private func configureTabBarAppearance() {
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .black
        
        // Custom View əlavə et (Arxa fon effekti)
        customTabBarView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        customTabBarView.layer.cornerRadius = 24
        customTabBarView.layer.masksToBounds = true
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(customTabBarView)
        view.bringSubviewToFront(tabBar)
        
        NSLayoutConstraint.activate([
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customTabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            customTabBarView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
        tabBar.tintColor = .white
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Animasiya və Effektlər
extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items,
              let index = items.firstIndex(of: item) else { return }
        
        // Köhnə çevrəni sil
        tabBar.subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        let itemCount = CGFloat(items.count)
        let tabBarWidth = tabBar.bounds.width
        let itemWidth = tabBarWidth / itemCount
        let circleSize: CGFloat = 50
        let circleX = CGFloat(index) * itemWidth + (itemWidth - circleSize)/2
        let circleY = (tabBar.bounds.height - circleSize)/2
        
        let circleView = UIView()
        circleView.tag = 999
        circleView.backgroundColor = UIColor.yellow
        circleView.layer.cornerRadius = circleSize/2
        circleView.frame = CGRect(x: circleX, y: circleY, width: circleSize, height: circleSize)
        tabBar.insertSubview(circleView, at: 0)
        
        // Animasiya üçün düyməni tap
        let tabBarButtons = tabBar.subviews.filter { String(describing: $0).contains("UITabBarButton") }
        guard index < tabBarButtons.count else { return }
        let selectedButton = tabBarButtons[index]
        
        // İkonu animasiya et
        if let imageView = selectedButton.subviews.compactMap({ $0 as? UIImageView }).first {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut,
                           animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    imageView.transform = .identity
                }
            }
        }
    }
}
// MARK: - Collection Safe Index
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
