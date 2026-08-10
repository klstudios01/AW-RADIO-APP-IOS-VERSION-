//
//  HeroLiveCard.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct HeroLiveCard: View {
    let station: RadioStation
    let program: Program?
    let onPlay: () -> Void
    
    @ObservedObject var audioManager = AudioStreamManager.shared
    
    var isCurrentStationPlaying: Bool {
        audioManager.currentStation?.id == station.id && audioManager.state == .playing
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background Artwork Image with AsyncImage
            AsyncImage(url: URL(string: station.bannerUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                default:
                    Color.royalBlueDark
                }
            }
            .frame(height: 220)
            .clipped()
            .overlay(
                LinearGradient(
                    colors: [Color.black.opacity(0.1), Color.darkBackground.opacity(0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            VStack(alignment: .leading, spacing: 12) {
                // Live Indicator Badge & Listener Counter
                HStack {
                    HStack(spacing: 6) {
                        Circle()
                            .fill(Color.liveRed)
                            .frame(width: 8, height: 8)
                        Text("LIVE BROADCAST")
                            .font(DesignSystem.Typography.badge)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.liveRed.opacity(0.25))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.liveRed, lineWidth: 1)
                    )
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "headphones")
                            .font(.system(size: 12))
                        Text(FormattingUtils.formatListenerCount(station.activeListeners))
                            .font(DesignSystem.Typography.caption)
                    }
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(12)
                }
                
                Spacer()
                
                // Show Title & Presenter Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(program?.title ?? station.name)
                        .font(DesignSystem.Typography.title2)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    
                    HStack(spacing: 8) {
                        Text("Host: \(program?.presenterName ?? "AW Radio")")
                            .font(DesignSystem.Typography.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("•")
                            .foregroundColor(.accentOrange)
                        
                        Text(station.frequency)
                            .font(DesignSystem.Typography.subheadline)
                            .foregroundColor(.accentOrange)
                            .fontWeight(.bold)
                    }
                }
                
                // Play Button Bar
                HStack {
                    Button(action: {
                        HapticsManager.shared.impact(style: .heavy)
                        onPlay()
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: isCurrentStationPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 18, weight: .bold))
                            Text(isCurrentStationPlaying ? "PAUSE STREAM" : "LISTEN LIVE NOW")
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(LinearGradient.accentGradient)
                        .cornerRadius(25)
                        .shadow(color: Color.accentOrange.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    
                    Spacer()
                }
            }
            .padding(16)
        }
        .frame(height: 220)
        .cornerRadius(20)
        .glassCard(cornerRadius: 20, borderOpacity: 0.25)
    }
}
