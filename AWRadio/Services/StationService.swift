//
//  StationService.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

@MainActor
final class StationService {
    static let shared = StationService()
    
    private init() {}
    
    func fetchStations() async -> [RadioStation] {
        // Fallback to rich mock data if backend request pending
        return RadioStation.mockList
    }
    
    func fetchFeaturedStation() async -> RadioStation {
        return RadioStation.mockList.first ?? RadioStation.mockList[0]
    }
}
