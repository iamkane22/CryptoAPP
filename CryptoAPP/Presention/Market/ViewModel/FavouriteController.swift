//
//  FavouriteController.swift
//  CryptoAPP
//
//  Created by Kenan on 06.02.25.
//

import UIKit

final class FavouriteController: UIViewController {
    
    private let viewModel: FavouriteVM
    init(viewModel: FavouriteVM) {
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
