//
//  HapticsManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import UIKit

@MainActor
final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {}
    
    func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
