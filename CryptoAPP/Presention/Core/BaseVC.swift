//
//  BaseVC.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
        configureConstraint()
        configureTargets()
    }
    
    open func configureView() {}
    open func configureConstraint() {}
    open func configureTargets() {}

}
