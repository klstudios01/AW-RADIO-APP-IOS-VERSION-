//
//  SearchViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var recentSearches: [String] = ["Morning Glory", "Praise & Worship", "Live News", "Pastor David"]
    @Published var trendingTags: [String] = ["Gospel", "Sports Arena", "Community Forum", "Live Stream"]
    
    @Published var matchingStations: [RadioStation] = []
    @Published var matchingPrograms: [Program] = []
    @Published var matchingNews: [NewsArticle] = []
    
    func performSearch() {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            matchingStations = []
            matchingPrograms = []
            matchingNews = []
            return
        }
        
        let q = query.lowercased()
        matchingStations = RadioStation.mockList.filter {
            $0.name.lowercased().contains(q) || $0.description.lowercased().contains(q)
        }
        matchingPrograms = Program.mockList.filter {
            $0.title.lowercased().contains(q) || $0.presenterName.lowercased().contains(q)
        }
        matchingNews = NewsArticle.mockList.filter {
            $0.title.lowercased().contains(q) || $0.summary.lowercased().contains(q)
        }
        
        if !recentSearches.contains(query) {
            recentSearches.insert(query, at: 0)
            if recentSearches.count > 5 {
                recentSearches = Array(recentSearches.prefix(5))
            }
        }
    }
    
    func clearHistory() {
        recentSearches = []
    }
}
