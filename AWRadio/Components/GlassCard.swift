//
//  GlassCard.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct GlassCard<Content: View>: View {
    var cornerRadius: CGFloat = 16
    var borderOpacity: CGFloat = 0.2
    var padding: CGFloat = 16
    let content: () -> Content
    
    init(cornerRadius: CGFloat = 16, borderOpacity: CGFloat = 0.2, padding: CGFloat = 16, @ViewBuilder content: @escaping () -> Content) {
        self.cornerRadius = cornerRadius
        self.borderOpacity = borderOpacity
        self.padding = padding
        self.content = content
    }
    
    var body: some View {
        content()
            .padding(padding)
            .glassCard(cornerRadius: cornerRadius, borderOpacity: borderOpacity)
    }
}
