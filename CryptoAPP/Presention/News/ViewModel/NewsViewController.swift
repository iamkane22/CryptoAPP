//
//  NewsViewController.swift
//  CryptoAPP
//
//  Created by Kenan on 06.02.25.
//

import UIKit

final class NewsViewController: UIViewController {
    
    private let viewModel: NewsVM
    init(viewModel: NewsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }


}
