//
//  SettingsViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

enum AudioQuality: String, CaseIterable, Identifiable {
    case high = "High (320 kbps)"
    case medium = "Medium (160 kbps)"
    case low = "Data Saver (64 kbps)"
    
    var id: String { self.rawValue }
}

@MainActor
final class SettingsViewModel: ObservableObject {
    @AppStorage("audioQuality") var selectedAudioQuality: AudioQuality = .high
    @AppStorage("autoPlayStream") var autoPlayStream: Bool = true
    @AppStorage("notificationsEnabled") var notificationsEnabled: Bool = true
    @Published var cacheSizeMB: String = "14.2 MB"
    
    func clearCache() {
        LocalCacheManager.shared.clearCache()
        cacheSizeMB = "0.0 MB"
        HapticsManager.shared.notification(type: .success)
    }
}
