//
//  SleepTimerManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import Combine

@MainActor
final class SleepTimerManager: ObservableObject {
    static let shared = SleepTimerManager()
    
    @Published var remainingSeconds: Int = 0
    @Published var isTimerActive: Bool = false
    
    private var timer: Timer?
    
    private init() {}
    
    func startTimer(minutes: Int) {
        cancelTimer()
        
        self.remainingSeconds = minutes * 60
        self.isTimerActive = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                guard let self = self else { return }
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                } else {
                    self.cancelTimer()
                    AudioStreamManager.shared.stop()
                    HapticsManager.shared.notification(type: .warning)
                }
            }
        }
    }
    
    func cancelTimer() {
        timer?.invalidate()
        timer = nil
        remainingSeconds = 0
        isTimerActive = false
    }
    
    var formattedRemainingTime: String {
        let mins = remainingSeconds / 60
        let secs = remainingSeconds % 60
        return String(format: "%02d:%02d", mins, secs)
    }
}
