//
//  ExpandedPlayerView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import AVKit

struct ExpandedPlayerView: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = PlayerViewModel()
    @ObservedObject var audioManager = AudioStreamManager.shared
    @ObservedObject var sleepTimerManager = SleepTimerManager.shared
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            // Blurred Artwork Background
            if let station = audioManager.currentStation {
                AsyncImage(url: URL(string: station.bannerUrl)) { phase in
                    if let img = phase.image {
                        img.resizable().aspectRatio(contentMode: .fill)
                    } else {
                        Color.royalBlueDark
                    }
                }
                .blur(radius: 40)
                .opacity(0.3)
                .ignoresSafeArea()
            }
            
            VStack(spacing: 24) {
                // Top Dismiss Header & AirPlay Button
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Text("LIVE PLAYER")
                        .font(DesignSystem.Typography.badge)
                        .foregroundColor(.accentOrange)
                        .tracking(2)
                    
                    Spacer()
                    
                    // Sleep Timer Trigger Button
                    Button(action: {
                        viewModel.isSleepTimerModalPresented = true
                    }) {
                        Image(systemName: sleepTimerManager.isTimerActive ? "timer.circle.fill" : "timer")
                            .font(.system(size: 22))
                            .foregroundColor(sleepTimerManager.isTimerActive ? .accentOrange : .white.opacity(0.8))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                
                Spacer()
                
                // Station Artwork Glass Container
                if let station = audioManager.currentStation {
                    ZStack {
                        AsyncImage(url: URL(string: station.logoUrl)) { phase in
                            if let img = phase.image {
                                img.resizable().aspectRatio(contentMode: .fill)
                            } else {
                                Color.royalBlueDark
                            }
                        }
                        .frame(width: 280, height: 280)
                        .cornerRadius(24)
                        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                }
                
                // Station & Host Info
                VStack(spacing: 8) {
                    Text(audioManager.currentStation?.name ?? "AW Radio Main Stream")
                        .font(DesignSystem.Typography.title1)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(audioManager.currentProgram?.title ?? audioManager.currentStation?.tagline ?? "Live Streaming")
                        .font(DesignSystem.Typography.title3)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Presenter: \(audioManager.currentProgram?.presenterName ?? "AW Desk")")
                        .font(DesignSystem.Typography.subheadline)
                        .foregroundColor(.accentOrange)
                }
                .padding(.horizontal)
                
                // Waveform Visualizer
                AnimatedWaveformView(isPlaying: audioManager.state == .playing, barCount: 24, maxHeight: 40)
                    .padding(.vertical, 8)
                
                // Volume Slider Control
                HStack(spacing: 16) {
                    Image(systemName: "speaker.fill")
                        .foregroundColor(.white.opacity(0.6))
                    
                    Slider(value: $audioManager.volume, in: 0...1)
                        .tint(.accentOrange)
                    
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.horizontal, 36)
                
                // Action Buttons Bar (Favorite, Play/Pause, Share)
                HStack(spacing: 36) {
                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundColor(viewModel.isFavorite ? .accentOrange : .white.opacity(0.8))
                    }
                    
                    Button(action: {
                        HapticsManager.shared.impact(style: .heavy)
                        audioManager.togglePlayPause()
                    }) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient.accentGradient)
                                .frame(width: 76, height: 76)
                                .shadow(color: Color.accentOrange.opacity(0.4), radius: 12, x: 0, y: 6)
                            
                            Image(systemName: audioManager.state == .playing ? "pause.fill" : "play.fill")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button(action: {
                        viewModel.isShareSheetPresented = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(.bottom, 24)
                
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isSleepTimerModalPresented) {
            SleepTimerModal(viewModel: viewModel)
        }
    }
}

struct SleepTimerModal: View {
    @ObservedObject var viewModel: PlayerViewModel
    
    var body: some View {
        ZStack {
            Color.darkBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Sleep Timer")
                    .font(DesignSystem.Typography.title2)
                    .foregroundColor(.white)
                    .padding(.top, 24)
                
                ForEach([15, 30, 45, 60], id: \.self) { mins in
                    Button(action: {
                        viewModel.setSleepTimer(minutes: mins)
                    }) {
                        Text("\(mins) Minutes")
                            .font(DesignSystem.Typography.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.sleepTimerManager.isTimerActive {
                    Button(action: {
                        viewModel.cancelSleepTimer()
                    }) {
                        Text("Cancel Timer (\(viewModel.sleepTimerManager.formattedRemainingTime))")
                            .font(DesignSystem.Typography.headline)
                            .foregroundColor(.liveRed)
                            .padding()
                    }
                }
                
                Spacer()
            }
        }
    }
}
