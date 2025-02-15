//
//  NewsListAPIHelper.swift
//  CryptoAPP
//
//  Created by Kenan on 12.02.25.
//
import UIKit

let key = "?auth_token=4fb1777c760f46d509a1a985e320e214667949a7&public=true"

enum NewsListAPIHelper {
    case news
    
    var endpoint: URL? {
        return CoreAPIHelper.instance.makeURL2(path: "posts/" + key)
       
    }
}
