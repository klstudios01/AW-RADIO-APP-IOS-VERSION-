//
//  MiniPlayerView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct MiniPlayerView: View {
    @ObservedObject var audioManager = AudioStreamManager.shared
    let onTap: () -> Void
    
    var body: some View {
        guard let station = audioManager.currentStation else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Button(action: {
                HapticsManager.shared.impact(style: .light)
                onTap()
            }) {
                HStack(spacing: 12) {
                    // Logo Image
                    AsyncImage(url: URL(string: station.logoUrl)) { phase in
                        if let img = phase.image {
                            img.resizable().aspectRatio(contentMode: .fill)
                        } else {
                            Color.royalBlueDark
                        }
                    }
                    .frame(width: 44, height: 44)
                    .cornerRadius(10)
                    
                    // Metadata Info
                    VStack(alignment: .leading, spacing: 2) {
                        Text(station.name)
                            .font(DesignSystem.Typography.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Text(audioManager.currentProgram?.title ?? station.tagline)
                            .font(DesignSystem.Typography.caption)
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Waveform visualizer when playing
                    if audioManager.state == .playing {
                        AnimatedWaveformView(isPlaying: true, barCount: 5, maxHeight: 18)
                    }
                    
                    // Play/Pause Control Button
                    Button(action: {
                        HapticsManager.shared.impact(style: .medium)
                        audioManager.togglePlayPause()
                    }) {
                        Image(systemName: audioManager.state == .playing ? "pause.fill" : "play.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Circle().fill(Color.accentOrange))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Color.darkSurface
                        .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
                )
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.white.opacity(0.1)),
                    alignment: .top
                )
            }
        )
    }
}
