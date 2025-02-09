//
//  MarketController.swift
//  CryptoAPP
//
//  Created by Kenan on 06.02.25.
//

import UIKit

final class MarketController: UIViewController {
    
    private let viewModel: MarketVM
    init(viewModel: MarketVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }


}
