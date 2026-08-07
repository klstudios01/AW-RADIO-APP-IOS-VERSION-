//
//  HomeViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var featuredStation: RadioStation?
    @Published var liveProgram: Program?
    @Published var recentlyPlayed: [RadioStation] = []
    @Published var recommendedStations: [RadioStation] = []
    @Published var selectedCategory: RadioStation.StationCategory = .all
    @Published var isLoading: Bool = false
    
    private let stationService = StationService.shared
    private let programService = ProgramService.shared
    
    func loadContent() async {
        isLoading = true
        let stations = await stationService.fetchStations()
        self.featuredStation = stations.first
        self.recommendedStations = Array(stations.dropFirst())
        self.recentlyPlayed = LocalCacheManager.shared.getRecentlyPlayed()
        
        if let featured = featuredStation {
            self.liveProgram = await programService.fetchLiveProgram(for: featured.id)
        }
        isLoading = false
    }
    
    var filteredStations: [RadioStation] {
        if selectedCategory == .all {
            return recommendedStations
        }
        return recommendedStations.filter { $0.category == selectedCategory }
    }
}
