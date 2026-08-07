//
//  ScheduleView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @ObservedObject var audioManager = AudioStreamManager.shared
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                // Title Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("BROADCAST SCHEDULE")
                            .font(DesignSystem.Typography.badge)
                            .foregroundColor(.accentOrange)
                            .tracking(1.5)
                        Text("Today's Shows")
                            .font(DesignSystem.Typography.title1)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Search Field
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.5))
                    TextField("Search programs or hosts...", text: $viewModel.searchQuery)
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Programs Schedule Timeline List
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.filteredPrograms) { program in
                            GlassCard(padding: 14) {
                                HStack(alignment: .top, spacing: 14) {
                                    // Host Avatar Image
                                    AsyncImage(url: URL(string: program.presenterAvatarUrl)) { phase in
                                        if let img = phase.image {
                                            img.resizable().aspectRatio(contentMode: .fill)
                                        } else {
                                            Color.royalBlueDark
                                        }
                                    }
                                    .frame(width: 54, height: 54)
                                    .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        HStack {
                                            if program.isLiveNow {
                                                Text("LIVE NOW")
                                                    .font(DesignSystem.Typography.badge)
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 2)
                                                    .background(Color.liveRed)
                                                    .cornerRadius(4)
                                            }
                                            
                                            Text(program.formattedScheduleTime)
                                                .font(DesignSystem.Typography.caption)
                                                .foregroundColor(.accentOrange)
                                                .fontWeight(.bold)
                                        }
                                        
                                        Text(program.title)
                                            .font(DesignSystem.Typography.headline)
                                            .foregroundColor(.white)
                                        
                                        Text("Host: \(program.presenterName)")
                                            .font(DesignSystem.Typography.subheadline)
                                            .foregroundColor(.white.opacity(0.8))
                                        
                                        Text(program.description)
                                            .font(DesignSystem.Typography.caption)
                                            .foregroundColor(.white.opacity(0.6))
                                            .lineLimit(2)
                                    }
                                    
                                    Spacer()
                                    
                                    // Reminder Bell Toggle Button
                                    Button(action: {
                                        PushNotificationManager.shared.scheduleShowReminder(program: program)
                                    }) {
                                        Image(systemName: "bell.badge")
                                            .foregroundColor(.accentOrange)
                                            .font(.system(size: 18))
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 120)
                }
            }
        }
        .task {
            await viewModel.loadSchedule()
        }
    }
}
