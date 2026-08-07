//
//  SectionHeader.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(DesignSystem.Typography.title3)
                .foregroundColor(.white)
            
            Spacer()
            
            if let actionTitle = actionTitle, let action = action {
                Button(action: {
                    HapticsManager.shared.selectionChanged()
                    action()
                }) {
                    Text(actionTitle)
                        .font(DesignSystem.Typography.subheadline)
                        .foregroundColor(.accentOrange)
                }
            }
        }
        .padding(.horizontal)
    }
}
