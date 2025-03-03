//
//  HomeController.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

//ededededede
import UIKit

class HomeController: BaseVC {
  
    
    private let viewModel: HomeVM
    private var updateTimer: Timer?
    private var autoScrollTimer: Timer?
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
    private lazy var newsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "BreakingNews"
        label.backgroundColor = .red
        label.layer.cornerRadius = 12
        return label
    }()
        private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.refreshControl = self.refreshControl
        return tv
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cell: NewsCellForHome.self)
        return collectionView
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
        configureViewModel()
        configureTable()
        setupViews()
        viewModel.type = .descending
        viewModel.getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startPolling()
        startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPolling()
        stopAutoScroll()
    }
        
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(loadingView)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(newsLabel)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

                tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),

                loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                newsLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 1),
                newsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                collectionView.heightAnchor.constraint(equalToConstant: 200)
                
            ])
    }
    
    fileprivate func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
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
                    self.collectionView.reloadData()
                case .error(let message):
                    self.showMessage(title: "Xeta", message: message)
                }
            }
        }
    }
    
    func startPolling(interval: TimeInterval = 20.0) {
        print("Polling started", Date())
        updateTimer?.invalidate()
        updateTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.segmentedControl.selectedSegmentIndex == 0 {
                self.viewModel.getCoinMarketData()
            } else {
                self.viewModel.getCoinSmallToBig()
            }
        }
    }
    
    func stopPolling() {
        updateTimer?.invalidate()
        updateTimer = nil
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
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 5.0,target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }

    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    @objc private func scrollToNextItem() {
        let itemCount = viewModel.getNewsList()
        guard itemCount > 0 else { return }
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if let currentIndexPath = visibleIndexPaths.first {
            let nextItem = (currentIndexPath.item + 1) % itemCount
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row , indexPath.section)
        viewModel.navigateDetail(for: indexPath.row)
                }
    }


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNewsList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCellForHome = collectionView.dequeue(for: indexPath)
        guard let viewModel = viewModel.getNewsProtocol(item: indexPath.row) else { return cell }
        cell.configure(model: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.getNewsProtocol(item: indexPath.row) else { return }
        let urlString = item.newsURL
        if let url = URL(string: urlString), !urlString.isEmpty {
            UIApplication.shared.open(url)
        }
        
        
        
    }
}
