//
//  Color+Theme.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

extension Color {
    // MARK: - Brand Green & Yellow Palette
    static let emeraldGreen = Color(red: 0.18, green: 0.49, blue: 0.20) // #2E7D32
    static let emeraldGreenLight = Color(red: 0.30, green: 0.69, blue: 0.31) // #4CAF50
    static let emeraldGreenDark = Color(red: 0.11, green: 0.37, blue: 0.13) // #1B5E20
    
    static let accentYellow = Color(red: 0.98, green: 0.75, blue: 0.18) // #FBC02D
    static let accentYellowLight = Color(red: 1.0, green: 0.84, blue: 0.31) // #FFD54F
    
    // MARK: - Compatibility Aliases for Theme Mapping
    static let royalBlue = emeraldGreen
    static let royalBlueLight = emeraldGreenLight
    static let royalBlueDark = emeraldGreenDark
    
    static let accentOrange = accentYellow
    static let accentOrangeLight = accentYellowLight
    
    // MARK: - Dark Background & Surface
    static let darkBackground = Color(red: 0.05, green: 0.12, blue: 0.08) // Deep Dark Green Surface
    static let darkSurface = Color(red: 0.09, green: 0.18, blue: 0.12)
    static let darkSurfaceLight = Color(red: 0.15, green: 0.28, blue: 0.18)
    
    // MARK: - Glassmorphism Overlay Colors
    static let glassBorder = Color.white.opacity(0.18)
    static let glassCardBackground = Color.white.opacity(0.08)
    static let glassHeaderBackground = Color(red: 0.05, green: 0.12, blue: 0.08).opacity(0.85)
    
    // MARK: - Status Indicators
    static let liveRed = Color(red: 0.94, green: 0.27, blue: 0.27)
    static let statusGreen = Color(red: 0.30, green: 0.69, blue: 0.31)
    
    // MARK: - Modern Green & Yellow Gradients
    static let brandGradient = LinearGradient(
        colors: [.emeraldGreenLight, .emeraldGreenDark],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        colors: [.accentYellowLight, .accentYellow],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let heroGradient = LinearGradient(
        colors: [Color.emeraldGreenLight.opacity(0.8), Color.darkBackground.opacity(0.95)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let glassGradient = LinearGradient(
        colors: [Color.white.opacity(0.14), Color.white.opacity(0.03)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
