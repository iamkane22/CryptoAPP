//
//  TabBarController.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
    }

    private func configureTabBarAppearance() {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 0.9).cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 0.9).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = tabBar.bounds

        // Add gradient to a view
        let gradientView = UIView(frame: tabBar.bounds)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Combine blur and gradient
        tabBar.insertSubview(blurEffectView, at: 0)
        tabBar.insertSubview(gradientView, at: 0)

        // Configure tab bar item appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear // Use gradient instead of solid color
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }
}
