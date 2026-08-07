//
//  AnimatedWaveformView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct AnimatedWaveformView: View {
    let isPlaying: Bool
    var barCount: Int = 18
    var maxHeight: CGFloat = 36
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(LinearGradient.accentGradient)
                    .frame(
                        width: 3,
                        height: isPlaying && isAnimating ? CGFloat.random(in: 8...maxHeight) : 6
                    )
                    .animation(
                        isPlaying ? Animation.easeInOut(duration: 0.45).repeatForever().delay(Double(index) * 0.05) : .default,
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            if isPlaying {
                isAnimating = true
            }
        }
        .onChange(of: isPlaying) { newValue in
            isAnimating = newValue
        }
    }
}
