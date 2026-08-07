//
//  Podcast.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct Podcast: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let description: String
    let presenter: String
    let audioUrl: String
    let artworkUrl: String
    let durationSeconds: TimeInterval
    let publishedAt: Date
    
    var formattedDuration: String {
        let mins = Int(durationSeconds) / 60
        return "\(mins) mins"
    }
    
    static var mockList: [Podcast] {
        [
            Podcast(
                id: "pod-01",
                title: "Daily Morning Sermon & Meditation",
                description: "Key takeaways and inspirational words from today's Morning Glory broadcast.",
                presenter: "Pastor David Miller",
                audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                artworkUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=600&q=80",
                durationSeconds: 1840,
                publishedAt: Date().addingTimeInterval(-86400)
            ),
            Podcast(
                id: "pod-02",
                title: "The Sports Roundtable - Episode 42",
                description: "Tactical breakdown of weekend championship games and interview with head coaches.",
                presenter: "AW Sports Desk",
                audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
                artworkUrl: "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=600&q=80",
                durationSeconds: 2450,
                publishedAt: Date().addingTimeInterval(-172800)
            )
        ]
    }
}
