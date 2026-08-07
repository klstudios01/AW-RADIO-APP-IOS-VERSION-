//
//  PrimaryButton.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var iconName: String? = nil
    var isGradient: Bool = true
    var isLoading: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            HapticsManager.shared.impact(style: .medium)
            action()
        }) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    if let icon = iconName {
                        Image(systemName: icon)
                            .font(.system(size: 16, weight: .bold))
                    }
                    Text(title)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                Group {
                    if isGradient {
                        LinearGradient.accentGradient
                    } else {
                        Color.royalBlueLight
                    }
                }
            )
            .cornerRadius(26)
            .shadow(color: isGradient ? Color.accentOrange.opacity(0.35) : Color.royalBlue.opacity(0.35), radius: 8, x: 0, y: 4)
        }
        .disabled(isLoading)
    }
}
