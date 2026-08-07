//
//  LocalCacheManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

final class LocalCacheManager {
    static let shared = LocalCacheManager()
    
    private let favoritesKey = "user_favorites_cache"
    private let recentlyPlayedKey = "recently_played_stations"
    
    private init() {}
    
    // MARK: - Favorites Caching
    func getCachedFavorites() -> [FavoriteItem] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let list = try? JSONDecoder().decode([FavoriteItem].self, from: data) else {
            return []
        }
        return list
    }
    
    func saveFavorites(_ favorites: [FavoriteItem]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
        }
    }
    
    func addFavorite(_ item: FavoriteItem) {
        var current = getCachedFavorites()
        if !current.contains(where: { $0.itemReferenceId == item.itemReferenceId }) {
            current.insert(item, at: 0)
            saveFavorites(current)
        }
    }
    
    func removeFavorite(referenceId: String) {
        var current = getCachedFavorites()
        current.removeAll(where: { $0.itemReferenceId == referenceId })
        saveFavorites(current)
    }
    
    func isFavorite(referenceId: String) -> Bool {
        return getCachedFavorites().contains(where: { $0.itemReferenceId == referenceId })
    }
    
    // MARK: - Recently Played Caching
    func getRecentlyPlayed() -> [RadioStation] {
        guard let data = UserDefaults.standard.data(forKey: recentlyPlayedKey),
              let list = try? JSONDecoder().decode([RadioStation].self, from: data) else {
            return RadioStation.mockList
        }
        return list
    }
    
    func addRecentlyPlayed(_ station: RadioStation) {
        var current = getRecentlyPlayed()
        current.removeAll(where: { $0.id == station.id })
        current.insert(station, at: 0)
        if current.count > 10 {
            current = Array(current.prefix(10))
        }
        if let data = try? JSONEncoder().encode(current) {
            UserDefaults.standard.set(data, forKey: recentlyPlayedKey)
        }
    }
    
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: favoritesKey)
        UserDefaults.standard.removeObject(forKey: recentlyPlayedKey)
    }
}
