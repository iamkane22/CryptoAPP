//
//  HomeController.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit

class HomeController: BaseVC {
    private let viewModel: HomeVM
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }


}

