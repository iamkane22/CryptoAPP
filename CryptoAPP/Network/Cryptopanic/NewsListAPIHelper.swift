//
//  NewsListAPIHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 12.02.25.
//
import UIKit

enum NewsListAPIHelper {
    case news
    
    var endpoint: URL? {
        return CoreAPIHelper.instance.makeURL2(path: "news/?lang=EN")
       
    }
}
