//
//  Program.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct Program: Identifiable, Codable, Hashable {
    let id: String
    let stationId: String
    let title: String
    let description: String
    let presenterName: String
    let presenterAvatarUrl: String
    let bannerUrl: String
    let startTime: Date
    let endTime: Date
    let category: String
    let isLiveNow: Bool
    
    var formattedScheduleTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return "\(formatter.string(from: startTime)) - \(formatter.string(from: endTime))"
    }
    
    static var mockList: [Program] {
        let calendar = Calendar.current
        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        
        return [
            Program(
                id: "prog-01",
                stationId: "station-01",
                title: "Morning Glory Drive",
                description: "Start your morning with inspiring gospel tunes, prayer minutes, and live news briefs.",
                presenterName: "Pastor David Miller",
                presenterAvatarUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=400&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=1000&q=80",
                startTime: calendar.date(byAdding: .hour, value: 6, to: startOfToday) ?? now,
                endTime: calendar.date(byAdding: .hour, value: 10, to: startOfToday) ?? now,
                category: "Gospel",
                isLiveNow: true
            ),
            Program(
                id: "prog-02",
                stationId: "station-01",
                title: "Midday Voice & Community Forum",
                description: "Deep dive into local affairs, healthcare tips, and audience call-ins with special guests.",
                presenterName: "Sarah Jenkins",
                presenterAvatarUrl: "https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&w=400&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1478737270239-2f02b77fc618?auto=format&fit=crop&w=1000&q=80",
                startTime: calendar.date(byAdding: .hour, value: 10, to: startOfToday) ?? now,
                endTime: calendar.date(byAdding: .hour, value: 14, to: startOfToday) ?? now,
                category: "Talk Shows",
                isLiveNow: false
            ),
            Program(
                id: "prog-03",
                stationId: "station-01",
                title: "Evening Worship & Healing",
                description: "Calm evening praise sessions, live testimony shares, and nocturnal prayers.",
                presenterName: "Michael Evans",
                presenterAvatarUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80",
                bannerUrl: "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=1000&q=80",
                startTime: calendar.date(byAdding: .hour, value: 18, to: startOfToday) ?? now,
                endTime: calendar.date(byAdding: .hour, value: 22, to: startOfToday) ?? now,
                category: "Gospel",
                isLiveNow: false
            )
        ]
    }
}
