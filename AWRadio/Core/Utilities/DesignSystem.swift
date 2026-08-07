//
//  DesignSystem.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

enum DesignSystem {
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let extraLarge: CGFloat = 24
        static let pill: CGFloat = 100
    }
    
    enum Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 12
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }
    
    enum Typography {
        static let title1 = Font.system(size: 28, weight: .bold, design: .rounded)
        static let title2 = Font.system(size: 22, weight: .bold, design: .rounded)
        static let title3 = Font.system(size: 18, weight: .semibold, design: .rounded)
        static let headline = Font.system(size: 16, weight: .bold, design: .default)
        static let body = Font.system(size: 15, weight: .regular, design: .default)
        static let subheadline = Font.system(size: 13, weight: .medium, design: .default)
        static let caption = Font.system(size: 11, weight: .medium, design: .default)
        static let badge = Font.system(size: 10, weight: .heavy, design: .rounded)
    }
}
