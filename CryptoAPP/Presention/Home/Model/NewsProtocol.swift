//
//  NewsProtocol.swift
//  CryptoAPP
//
//  Created by Kenan on 13.02.25.
//

protocol NewsProtocol {
    var thumbnailimage: String { get }
    var titleNews: String { get }
    var domainNews: String { get }
    var dateNews: String { get }
    var sourceNews: String { get }
    var newsURL: String { get }
}

//contentView.addSubview(thumbnailImageView)
//contentView.addSubview(titleLabel)
//contentView.addSubview(domainLabel)
//contentView.addSubview(dateLabel)
//contentView.addSubview(sourceLabel)
