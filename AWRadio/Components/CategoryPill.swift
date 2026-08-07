//
//  CategoryPill.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticsManager.shared.selectionChanged()
            action()
        }) {
            Text(title)
                .font(.system(size: 14, weight: isSelected ? .bold : .medium, design: .rounded))
                .foregroundColor(isSelected ? .white : .white.opacity(0.7))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.royalBlueLight : Color.white.opacity(0.08))
                )
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.white.opacity(0.3) : Color.white.opacity(0.1), lineWidth: 1)
                )
        }
    }
}
