//
//  FavoritesViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteItem] = []
    @Published var selectedSegment: FavoriteItem.FavoriteType = .station
    
    func loadFavorites() {
        self.favorites = LocalCacheManager.shared.getCachedFavorites()
    }
    
    func removeFavorite(id: String) {
        LocalCacheManager.shared.removeFavorite(referenceId: id)
        loadFavorites()
    }
    
    var filteredFavorites: [FavoriteItem] {
        return favorites.filter { $0.itemType == selectedSegment }
    }
}
