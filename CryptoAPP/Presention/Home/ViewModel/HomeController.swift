//
//  HomeController.swift
//  CryptoAPP
//
//  Created by Kenan on 04.02.25.
//

import UIKit

class HomeController: BaseVC {
    private let viewModel: HomeVM
    private let layout: HomeLayouts?
    init(viewModel: HomeVM) {
        self.viewModel = viewModel
        self.layout = HomeLayouts()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var collectionView: UICollectionView = {
        let l = UICollectionViewFlowLayout()
        l.minimumLineSpacing = 12
        l.minimumInteritemSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout:l)
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(cell: CryptoCell.self)
//        cv.register(cell: TrandingSectionCell.self)
//        cv.register(header: SectionHeader.self)
//        cv.register(cell: PopularCell.self)
//        cv.register(cell: TopRatedCell.self)
        cv.backgroundColor = .clear
        cv.refreshControl = refreshControl
        return cv
    }()
    private lazy var refreshControl = UIRefreshControl().withUsing {
        $0.addTarget(self, action: #selector(reloadPage), for: .valueChanged)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCoinList()
        viewModel.getCoinMarketData()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startPolling()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    @objc
    private func reloadPage() {
        viewModel.getCoinMarketData()
    }
}

extension HomeController {
    fileprivate func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            guard let self = self else {return nil}
            switch sectionIndex {
            case 0 : return self.layout?.trandingSegmentSection()
            case 1 : return self.layout?.trandingSection()
            default: return self.layout?.trandingSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}


extension HomeController: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSections section: Int) -> Int {
            switch section {
            case 0: return 1
            case 1 : return 4
            case 2 : return 3
            default: return 1
            }
        }
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CryptoCell = collectionView.dequeue(for: indexPath)
        return cell
    }
    
    
}
