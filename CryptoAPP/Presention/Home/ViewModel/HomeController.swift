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
    
//    private lazy var segmentedControl: UISegmentedControl = {
//        let control = UISegmentedControl(items: ["Top Coins", "Top Gainers", "Top Losers"])
//        control.selectedSegmentIndex = 0
//        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
//        return control
//    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var refreshControl = UIRefreshControl().withUsing {
        $0.addTarget(self, action: #selector(reloadPage), for: .valueChanged)

    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureViewModel()
        viewModel.getCoinMarketData()
        viewModel.getCoinSmallToBig()
    }
    
    fileprivate func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: CryptoCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startPolling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.stopPolling()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(tableView)
    }
    
    override func configureConstraint() {
        super.configureConstraint()

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    @objc
    private func reloadPage() {
        viewModel.getCoinMarketData()
    }
    
    fileprivate func configureViewModel() {
        viewModel.requestCallback = { [weak self] state in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch state {
                    case .loading:
                        self.loadingView.startAnimating()
                    case .loaded:
                        self.loadingView.stopAnimating()
                    self.refreshControl.endRefreshing()
                case .succes:
                    self.tableView.reloadData()
                case .error(let message):
                        self.showMessage(title: "Xeta", message: message)
                }
            }
        }
    }
    
}
extension HomeController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCoins()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: CryptoCell.self, for: indexPath)
        guard let item = viewModel.getProtocol(item: indexPath.row) else { return UITableViewCell() }
        cell.configure(coin: item )
        return cell
    }
    
    
}




