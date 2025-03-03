//
//  FavoriteCoinsManager.swift
//  CryptoAPP
//
//  Created by Kenan on 03.03.25.
//

import Foundation

class FavoriteCoinsManager {
    static let shared = FavoriteCoinsManager()
    
    private let favoritesKey = "favoriteCoins"

    private init() {}

    func getFavorites() -> [String] {
        return UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
    }

    func addFavorite(_ coinID: String) {
        var favorites = getFavorites()
        if !favorites.contains(coinID) {
            favorites.append(coinID)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }

    func removeFavorite(_ coinID: String) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == coinID }
        UserDefaults.standard.set(favorites, forKey: favoritesKey)
    }

    func isFavorite(_ coinID: String) -> Bool {
        return getFavorites().contains(coinID)
    }
}
