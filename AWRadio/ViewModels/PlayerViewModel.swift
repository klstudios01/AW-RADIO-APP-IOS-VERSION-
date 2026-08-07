//
//  PlayerViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class PlayerViewModel: ObservableObject {
    @Published var audioManager = AudioStreamManager.shared
    @Published var sleepTimerManager = SleepTimerManager.shared
    @Published var isFavorite: Bool = false
    @Published var isShareSheetPresented: Bool = false
    @Published var isSleepTimerModalPresented: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        audioManager.$currentStation
            .sink { [weak self] station in
                if let station = station {
                    self?.isFavorite = LocalCacheManager.shared.isFavorite(referenceId: station.id)
                }
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite() {
        guard let station = audioManager.currentStation else { return }
        
        let favorite = FavoriteItem(
            id: UUID().uuidString,
            userId: AuthManager.shared.currentUser?.id ?? "guest",
            itemType: .station,
            itemReferenceId: station.id,
            title: station.name,
            subtitle: station.tagline,
            imageUrl: station.logoUrl,
            addedAt: Date()
        )
        
        FavoriteService.shared.toggleFavorite(item: favorite)
        isFavorite = LocalCacheManager.shared.isFavorite(referenceId: station.id)
        HapticsManager.shared.impact(style: .light)
    }
    
    func setSleepTimer(minutes: Int) {
        sleepTimerManager.startTimer(minutes: minutes)
        isSleepTimerModalPresented = false
    }
    
    func cancelSleepTimer() {
        sleepTimerManager.cancelTimer()
        isSleepTimerModalPresented = false
    }
}
