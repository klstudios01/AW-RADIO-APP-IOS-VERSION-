//
//  FavoriteItem.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct FavoriteItem: Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let itemType: FavoriteType
    let itemReferenceId: String
    let title: String
    let subtitle: String
    let imageUrl: String
    let addedAt: Date
    
    enum FavoriteType: String, Codable, CaseIterable {
        case station = "station"
        case program = "program"
        case news = "news"
    }
}
