//
//  AppNotification.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct AppNotification: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let body: String
    let imageUrl: String?
    let category: NotificationCategory
    let sentAt: Date
    var isRead: Bool
    
    enum NotificationCategory: String, Codable, CaseIterable {
        case liveShow = "Favorite Show Starts"
        case breakingNews = "Breaking News"
        case specialEvents = "Special Events"
        case systemAlert = "System Updates"
    }
    
    static var mockList: [AppNotification] {
        [
            AppNotification(
                id: "notif-01",
                title: "Live Broadcast Starting Now!",
                body: "Morning Glory Drive with Pastor David Miller is now live on AW Radio Main Stream.",
                imageUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=400&q=80",
                category: .liveShow,
                sentAt: Date().addingTimeInterval(-1200),
                isRead: false
            ),
            AppNotification(
                id: "notif-02",
                title: "Breaking News Alert",
                body: "AW Radio launches native Dynamic Island & CarPlay integration across all iOS devices.",
                imageUrl: "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?auto=format&fit=crop&w=400&q=80",
                category: .breakingNews,
                sentAt: Date().addingTimeInterval(-7200),
                isRead: true
            )
        ]
    }
}
