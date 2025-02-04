//
//  MainExtensions.swift
//  MovieApp
//
//  Created by Kenan on 21.12.24.
//

import Foundation
import UIKit
//import SDWebImage

extension Double {
    func convertToString() -> String {
        return String(self)
    }
}

extension Int {
    func convertToString() -> String {
        return String(self)
    }
}

extension UITableView {
    
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableHeaderView = headerView
        
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    func updateHeaderViewFrame() {
        guard let headerView = self.tableHeaderView else { return }
        
        headerView.layoutIfNeeded()
        
        let header = self.tableHeaderView
        self.tableHeaderView = header
    }
    
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
}
extension UITableView {
    
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}

extension UITableView {
    
    public func dequeue<T: UITableViewCell>(cellClass: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T
    }
    
    public func dequeue<T: UITableViewCell>(
        cellClass: T.Type,
        forIndexPath indexPath: IndexPath
    ) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: cellClass.reuseIdentifier,
            for: indexPath) as? T else {
            fatalError(
                "Error: cell with id: \(cellClass.reuseIdentifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(header: T.Type) {
        
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(footer: T.Type) {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.reuseIdentifier)
    }
    
}

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T
    }
}

extension UICollectionView {
    // Existing code for registering cells and supplementary views
    
    func dequeue<T: UICollectionReusableView>(
        header: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T
    }
    
    func dequeue<T: UICollectionReusableView>(
        footer: T.Type,
        for indexPath: IndexPath
    ) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as! T
    }
}


extension UIViewController {
    func showMessage(
        title: String = "",
        message: String = "",
        actionTitle: String = "OK"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func addSubViews(_ views: UIView ...) {
        views.forEach({addSubview($0)})
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView ...) {
        
    }
}
extension String {
    
    var isNotEmpty: Bool {
    return !self.isEmpty
}
    
    func isValidPassword() -> Bool {
        count > 8
    }
    
    func isValidEmailMask() -> Bool  {
        count > 5
    }
    
    
    func isValidName() -> Bool {
        count > 2
    }
}

extension UIImageView {
    func loadImageURL(url: String) {
        guard let url = URL(string: url) else {return}
//        print(#function, url)
//        self.sd_setImage(with: url)
    }
}

extension UIEdgeInsets {
    // Initialize UIEdgeInsets with equal padding for all sides
    public init(all value: CGFloat) {
        self = .init(top: value, left: value, bottom: -value, right: -value)
    }
    
    // Initialize UIEdgeInsets with individual padding values for each side
    public init(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        self = .init(top: top, left: leading, bottom: bottom, right: trailing)
    }
    
    // Initialize UIEdgeInsets with equal vertical and horizontal padding
    public init(y: CGFloat = 0, x: CGFloat = 0) {
        self = .init(top: y, left: x, bottom: -y, right: -x)
    }
    
    // Initialize UIEdgeInsets with specified top, horizontal, and bottom padding
    public init(top: CGFloat = 0, x: CGFloat, bottom: CGFloat = 0) {
        self = .init(top: top, left: x, bottom: bottom, right: -x)
    }
}
