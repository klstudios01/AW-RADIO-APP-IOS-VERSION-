//
//  FormattingUtils.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct FormattingUtils {
    static func formatDuration(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    static func formatListenerCount(_ count: Int) -> String {
        if count >= 1000 {
            let kCount = Double(count) / 1000.0
            return String(format: "%.1fK listeners", kCount)
        }
        return "\(count) listeners"
    }
}
