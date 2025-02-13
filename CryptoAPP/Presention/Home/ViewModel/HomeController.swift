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
    
    // MARK: - UI Elements
        private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(reloadPage), for: .valueChanged)
        return refresh
    }()
        private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.refreshControl = self.refreshControl
        return tv
    }()
        private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Coxdan Aza", "Azdan Coxa"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        return control
    }()
        private lazy var loadingView: UIActivityIndicatorView = {
        let lv = UIActivityIndicatorView(style: .large)
        lv.hidesWhenStopped = true
        lv.translatesAutoresizingMaskIntoConstraints = false
        return lv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureViewModel()
        setupViews()
        viewModel.getCoinMarketData()
        viewModel.getCoinSmallToBig()
        viewModel.getNews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startPolling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopPolling()
    }
        
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(loadingView)
        
        let headerContainer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        headerContainer.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
            segmentedControl.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16)
        ])
        tableView.tableHeaderView = headerContainer
            NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    fileprivate func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: CryptoCell.self)
        tableView.register(cell: CryptoSmallToBigCell.self)
    }
    
    fileprivate func configureViewModel() {
        viewModel.requestCallback = { [weak self] state in
            guard let self = self else { return }
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
    
    // MARK: - Actions
    
    @objc private func reloadPage() {
        viewModel.getCoinMarketData()
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.applySort(order: .descending)
        } else {
            viewModel.applySort(order: .ascending)
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCoins()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(for: CryptoCell.self, for: indexPath)
            if let item = viewModel.getProtocol(item: indexPath.row) {
                cell.configure(coin: item)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: CryptoSmallToBigCell.self, for: indexPath)
            if let item = viewModel.getProtocol(item: indexPath.row) {
                cell.configure(coin: item)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
