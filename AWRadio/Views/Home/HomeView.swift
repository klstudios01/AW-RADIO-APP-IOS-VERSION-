//
//  HomeView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @ObservedObject var authManager = AuthManager.shared
    @ObservedObject var audioManager = AudioStreamManager.shared
    
    var onSelectTab: (TabItem) -> Void
    var onOpenPlayer: () -> Void
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header Bar (Greeting + Profile + Notification Icon)
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("GOOD \(greetingTime().uppercased())")
                                .font(DesignSystem.Typography.caption)
                                .foregroundColor(.accentOrange)
                                .fontWeight(.bold)
                                .tracking(1.5)
                            
                            Text(authManager.currentUser?.fullName ?? "Welcome Listener")
                                .font(DesignSystem.Typography.title1)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        // Notification Bell Button
                        Button(action: {
                            HapticsManager.shared.selectionChanged()
                            onSelectTab(.news)
                        }) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.white.opacity(0.08))
                                    .clipShape(Circle())
                                
                                Circle()
                                    .fill(Color.accentOrange)
                                    .frame(width: 10, height: 10)
                                    .offset(x: 2, y: -2)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Live Hero Broadcast Card
                    if let station = viewModel.featuredStation {
                        HeroLiveCard(
                            station: station,
                            program: viewModel.liveProgram,
                            onPlay: {
                                audioManager.play(station: station, program: viewModel.liveProgram)
                                onOpenPlayer()
                            }
                        )
                        .padding(.horizontal)
                    } else {
                        SkeletonLoader(height: 220, cornerRadius: 20)
                            .padding(.horizontal)
                    }
                    
                    // Category Selection Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(RadioStation.StationCategory.allCases) { cat in
                                CategoryPill(
                                    title: cat.rawValue,
                                    isSelected: viewModel.selectedCategory == cat,
                                    action: {
                                        viewModel.selectedCategory = cat
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Recently Played Stations Section
                    if !viewModel.recentlyPlayed.isEmpty {
                        VStack(spacing: 12) {
                            SectionHeader(title: "Recently Played")
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.recentlyPlayed) { station in
                                        Button(action: {
                                            audioManager.play(station: station)
                                            onOpenPlayer()
                                        }) {
                                            VStack(alignment: .leading, spacing: 8) {
                                                AsyncImage(url: URL(string: station.logoUrl)) { phase in
                                                    if let img = phase.image {
                                                        img.resizable().aspectRatio(contentMode: .fill)
                                                    } else {
                                                        Color.royalBlueDark
                                                    }
                                                }
                                                .frame(width: 110, height: 110)
                                                .cornerRadius(16)
                                                .glassCard(cornerRadius: 16)
                                                
                                                Text(station.name)
                                                    .font(DesignSystem.Typography.caption)
                                                    .foregroundColor(.white)
                                                    .lineLimit(1)
                                                    .frame(width: 110, alignment: .leading)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Recommended Radio Stations Grid
                    VStack(spacing: 12) {
                        SectionHeader(title: "Radio Stations")
                        
                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredStations) { station in
                                GlassCard(padding: 12) {
                                    HStack(spacing: 14) {
                                        AsyncImage(url: URL(string: station.logoUrl)) { phase in
                                            if let img = phase.image {
                                                img.resizable().aspectRatio(contentMode: .fill)
                                            } else {
                                                Color.royalBlueDark
                                            }
                                        }
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(12)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(station.name)
                                                .font(DesignSystem.Typography.headline)
                                                .foregroundColor(.white)
                                            
                                            Text(station.tagline)
                                                .font(DesignSystem.Typography.caption)
                                                .foregroundColor(.white.opacity(0.7))
                                                .lineLimit(1)
                                            
                                            HStack(spacing: 6) {
                                                Text(station.category.rawValue)
                                                    .font(.system(size: 10, weight: .bold))
                                                    .foregroundColor(.accentOrange)
                                                    .padding(.horizontal, 6)
                                                    .padding(.vertical, 2)
                                                    .background(Color.accentOrange.opacity(0.15))
                                                    .cornerRadius(6)
                                                
                                                Text(station.frequency)
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundColor(.white.opacity(0.6))
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            audioManager.play(station: station)
                                            onOpenPlayer()
                                        }) {
                                            Circle()
                                                .fill(LinearGradient.accentGradient)
                                                .frame(width: 42, height: 42)
                                                .overlay(
                                                    Image(systemName: "play.fill")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 16, weight: .bold))
                                                )
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 120)
                }
            }
        }
        .task {
            await viewModel.loadContent()
        }
    }
    
    private func greetingTime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Morning" }
        if hour < 17 { return "Afternoon" }
        return "Evening"
    }
}
