//
//  RadioStation.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct RadioStation: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let tagline: String
    let description: String
    let logoUrl: String
    let bannerUrl: String
    let streamUrl: String
    let website: String
    let category: StationCategory
    let isLive: Bool
    let activeListeners: Int
    let frequency: String
    
    enum StationCategory: String, Codable, CaseIterable, Identifiable {
        case all = "All"
        case gospel = "Gospel"
        case news = "News"
        case sports = "Sports"
        case entertainment = "Entertainment"
        case education = "Education"
        case talk = "Talk Shows"
        
        var id: String { self.rawValue }
    }
    
    static var mockList: [RadioStation] {
        [
            RadioStation(
                id: "station-01",
                name: "AW Radio Main Stream",
                tagline: "Listen Live. Anytime. Anywhere.",
                description: "The flagship broadcast station bringing you live inspirational gospel music, breaking news, live talk shows, and community discussions.",
                logoUrl: "https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?auto=format&fit=crop&w=600&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=1200&q=80",
                streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv",
                website: "https://awradio.app",
                category: .gospel,
                isLive: true,
                activeListeners: 4820,
                frequency: "104.5 FM"
            ),
            RadioStation(
                id: "station-02",
                name: "AW News & Talk 24/7",
                tagline: "Your Daily Voice of Truth",
                description: "Non-stop national & global news coverage, expert economic analysis, and live caller forums.",
                logoUrl: "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?auto=format&fit=crop&w=600&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1495020689067-958852a7765e?auto=format&fit=crop&w=1200&q=80",
                streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv",
                website: "https://awradio.app/news",
                category: .news,
                isLive: true,
                activeListeners: 3120,
                frequency: "98.1 FM"
            ),
            RadioStation(
                id: "station-03",
                name: "AW Praise & Worship",
                tagline: "Uplifting Faith & Inspiration",
                description: "Pure gospel music, live worship sessions, and morning devotionals.",
                logoUrl: "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=600&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?auto=format&fit=crop&w=1200&q=80",
                streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv",
                website: "https://awradio.app/praise",
                category: .gospel,
                isLive: true,
                activeListeners: 6540,
                frequency: "107.9 FM"
            ),
            RadioStation(
                id: "station-04",
                name: "AW Sports Arena",
                tagline: "Live Commentary & Analysis",
                description: "Live match coverage, post-game breakdowns, and exclusive athlete interviews.",
                logoUrl: "https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=600&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=1200&q=80",
                streamUrl: "https://stream.zeno.fm/f3wvbbqmdg8uv",
                website: "https://awradio.app/sports",
                category: .sports,
                isLive: true,
                activeListeners: 2190,
                frequency: "92.3 FM"
            )
        ]
    }
}
