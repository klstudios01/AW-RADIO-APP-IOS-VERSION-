//
//  AnalyticsManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

final class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func trackEvent(name: String, parameters: [String: Any] = [:]) {
        #if DEBUG
        print("📊 [Analytics] \(name): \(parameters)")
        #endif
    }
    
    func trackStationPlayback(stationId: String, stationName: String) {
        trackEvent(name: "station_play", parameters: [
            "station_id": stationId,
            "station_name": stationName,
            "timestamp": Date().timeIntervalSince1970
        ])
    }
    
    func trackNewsView(articleId: String, title: String) {
        trackEvent(name: "news_view", parameters: [
            "article_id": articleId,
            "article_title": title
        ])
    }
}
