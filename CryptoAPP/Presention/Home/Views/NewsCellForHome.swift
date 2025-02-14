//
//  NewsCellForHome.swift
//  CryptoAPP
//
//  Created by Kenan on 14.02.25.
//

import UIKit


final class NewsCellForHome: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 4
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sourceLabel: UILabel = {
        let label1 = UILabel()
        label1.font = UIFont.italicSystemFont(ofSize: 10)
        label1.textColor = .darkGray
        label1.translatesAutoresizingMaskIntoConstraints = false
        return label1
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: NewsProtocol) {
        thumbnailImageView.loadImageURL(url: model.thumbnailimage)
        titleLabel.text = model.titleNews
        domainLabel.text = model.domainNews
        dateLabel.text = model.dateNews
        sourceLabel.text = model.sourceNews
    }
    
    private func setupUI() {
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 8
            contentView.layer.masksToBounds = true
            
            contentView.addSubview(thumbnailImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(domainLabel)
            contentView.addSubview(dateLabel)
            contentView.addSubview(sourceLabel)
            
            NSLayoutConstraint.activate([
                thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
                thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
                
                titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 4),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                
                domainLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
                domainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                domainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
                
                dateLabel.topAnchor.constraint(equalTo: domainLabel.bottomAnchor, constant: 2),
                dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
                sourceLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
                sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
            ])
        
        }
    
}


