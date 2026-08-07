//
//  NewsArticle.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct NewsArticle: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let summary: String
    let content: String
    let imageUrl: String
    let category: String
    let author: String
    let publishedAt: Date
    let readTimeMinutes: Int
    var isBookmarked: Bool
    
    static var mockList: [NewsArticle] {
        [
            NewsArticle(
                id: "news-01",
                title: "AW Radio Expands Live Broadcasting to Apple Dynamic Island & CarPlay",
                summary: "AW Radio releases state-of-the-art iOS features enabling seamless background streaming, widgets, and dynamic live activity tracking.",
                content: """
                AW Radio has officially launched its flagship iOS application built on Swift 6 and SwiftUI. 
                
                Listeners around the globe can now experience crystal-clear audio streams with automatic stream reconnection, background playback, Lock Screen controls, and full Dynamic Island support.
                
                The application also features a real-time schedule, breaking news portal, podcast library, and custom equalizer settings.
                """,
                imageUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=1000&q=80",
                category: "Technology",
                author: "AW Media Desk",
                publishedAt: Date().addingTimeInterval(-3600 * 3),
                readTimeMinutes: 4,
                isBookmarked: true
            ),
            NewsArticle(
                id: "news-02",
                title: "Annual Gospel Music Festival 2026 Announced for October",
                summary: "Top international worship ministers and choirs gather for a 3-day live radio broadcast event.",
                content: """
                AW Radio is thrilled to announce the 2026 Gospel Music & Praise Festival, taking place live across our primary stream networks.
                
                The event will feature interactive live sessions, presenter q&a, and exclusive acoustic performances recorded directly in high-definition digital audio.
                """,
                imageUrl: "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=1000&q=80",
                category: "Entertainment",
                author: "Events Team",
                publishedAt: Date().addingTimeInterval(-3600 * 12),
                readTimeMinutes: 3,
                isBookmarked: false
            ),
            NewsArticle(
                id: "news-03",
                title: "Global Community Spotlight: Youth Empowerment & Education Hour",
                summary: "Discover how AW Radio's educational talk shows are inspiring students across the country.",
                content: """
                In our weekly Community Spotlight feature, we explore how educational talk shows are reaching over 50,000 young listeners each morning.
                """,
                imageUrl: "https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=1000&q=80",
                category: "Education",
                author: "Community Editor",
                publishedAt: Date().addingTimeInterval(-3600 * 24),
                readTimeMinutes: 5,
                isBookmarked: false
            )
        ]
    }
}
