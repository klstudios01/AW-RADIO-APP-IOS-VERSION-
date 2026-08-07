//
//  Color+Theme.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

extension Color {
    // MARK: - Brand Colors
    static let royalBlue = Color(red: 0.12, green: 0.23, blue: 0.54) // #1E3A8A
    static let royalBlueLight = Color(red: 0.15, green: 0.39, blue: 0.92) // #2563EB
    static let royalBlueDark = Color(red: 0.08, green: 0.15, blue: 0.38)
    
    static let accentOrange = Color(red: 0.98, green: 0.45, blue: 0.09) // #F97316
    static let accentOrangeLight = Color(red: 0.99, green: 0.58, blue: 0.24)
    
    // MARK: - Dark Background & Surface
    static let darkBackground = Color(red: 0.06, green: 0.09, blue: 0.16) // #0F172A
    static let darkSurface = Color(red: 0.12, green: 0.16, blue: 0.24) // #1E293B
    static let darkSurfaceLight = Color(red: 0.20, green: 0.25, blue: 0.35)
    
    // MARK: - Glassmorphism Overlay Colors
    static let glassBorder = Color.white.opacity(0.15)
    static let glassCardBackground = Color.white.opacity(0.06)
    static let glassHeaderBackground = Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.85)
    
    // MARK: - Status Indicators
    static let liveRed = Color(red: 0.94, green: 0.27, blue: 0.27)
    static let statusGreen = Color(red: 0.13, green: 0.77, blue: 0.36)
    
    // MARK: - Modern Gradients
    static let brandGradient = LinearGradient(
        colors: [.royalBlueLight, .royalBlue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accentGradient = LinearGradient(
        colors: [.accentOrangeLight, .accentOrange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let heroGradient = LinearGradient(
        colors: [Color.royalBlueLight.opacity(0.8), Color.darkBackground.opacity(0.95)],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let glassGradient = LinearGradient(
        colors: [Color.white.opacity(0.12), Color.white.opacity(0.03)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
