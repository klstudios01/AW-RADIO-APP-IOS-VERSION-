//
//  FavoriteService.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

@MainActor
final class FavoriteService {
    static let shared = FavoriteService()
    
    private init() {}
    
    func fetchFavorites(userId: String) async -> [FavoriteItem] {
        return LocalCacheManager.shared.getCachedFavorites()
    }
    
    func toggleFavorite(item: FavoriteItem) {
        if LocalCacheManager.shared.isFavorite(referenceId: item.itemReferenceId) {
            LocalCacheManager.shared.removeFavorite(referenceId: item.itemReferenceId)
        } else {
            LocalCacheManager.shared.addFavorite(item)
        }
    }
}
