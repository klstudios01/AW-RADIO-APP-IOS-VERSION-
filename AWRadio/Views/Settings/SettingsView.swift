//
//  SettingsView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header Bar
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                    Text("SETTINGS")
                        .font(DesignSystem.Typography.badge)
                        .foregroundColor(.accentOrange)
                        .tracking(2)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Audio Quality Settings Group
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Audio Playback Quality")
                                .font(DesignSystem.Typography.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            GlassCard {
                                VStack(spacing: 12) {
                                    ForEach(AudioQuality.allCases) { quality in
                                        Button(action: {
                                            viewModel.selectedAudioQuality = quality
                                        }) {
                                            HStack {
                                                Text(quality.rawValue)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                if viewModel.selectedAudioQuality == quality {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.accentOrange)
                                                        .fontWeight(.bold)
                                                }
                                            }
                                            .padding(.vertical, 4)
                                        }
                                        if quality != AudioQuality.allCases.last {
                                            Divider().background(Color.white.opacity(0.1))
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Stream Preferences Group
                        VStack(alignment: .leading, spacing: 10) {
                            Text("General Preferences")
                                .font(DesignSystem.Typography.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            GlassCard {
                                VStack(spacing: 16) {
                                    Toggle(isOn: $viewModel.autoPlayStream) {
                                        Text("Auto Play Stream on Launch")
                                            .foregroundColor(.white)
                                    }
                                    .tint(.accentOrange)
                                    
                                    Divider().background(Color.white.opacity(0.1))
                                    
                                    Toggle(isOn: $viewModel.notificationsEnabled) {
                                        Text("Push Notifications")
                                            .foregroundColor(.white)
                                    }
                                    .tint(.accentOrange)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Cache Management Group
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Storage & Cache")
                                .font(DesignSystem.Typography.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            GlassCard {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Cached Artwork & Schedules")
                                            .foregroundColor(.white)
                                        Text(viewModel.cacheSizeMB)
                                            .font(DesignSystem.Typography.caption)
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    Spacer()
                                    Button(action: {
                                        viewModel.clearCache()
                                    }) {
                                        Text("Clear Cache")
                                            .font(DesignSystem.Typography.caption)
                                            .foregroundColor(.liveRed)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.liveRed.opacity(0.15))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // App Details & Version
                        VStack(spacing: 6) {
                            Text("AW Radio v1.0.0 (Build 100)")
                                .font(DesignSystem.Typography.caption)
                                .foregroundColor(.white.opacity(0.5))
                            Text("Developed with Swift 6 & SwiftUI")
                                .font(DesignSystem.Typography.caption)
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}
