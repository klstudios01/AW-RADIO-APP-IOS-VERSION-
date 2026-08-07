//
//  SkeletonLoader.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SkeletonLoader: View {
    var height: CGFloat = 20
    var width: CGFloat? = nil
    var cornerRadius: CGFloat = 8
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.20),
                        Color.white.opacity(0.08)
                    ],
                    startPoint: isAnimating ? .leading : .trailing,
                    endPoint: isAnimating ? .trailing : .leading
                )
            )
            .frame(width: width, height: height)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}
