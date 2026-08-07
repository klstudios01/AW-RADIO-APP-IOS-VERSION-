//
//  MainContainerView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct MainContainerView: View {
    @State private var selectedTab: TabItem = .home
    @StateObject private var audioManager = AudioStreamManager.shared
    @State private var isExpandedPlayerPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.darkBackground
                .ignoresSafeArea()
            
            // Tab Views
            Group {
                switch selectedTab {
                case .home:
                    HomeView(onSelectTab: { tab in selectedTab = tab }, onOpenPlayer: { isExpandedPlayerPresented = true })
                case .live:
                    HomeView(onSelectTab: { tab in selectedTab = tab }, onOpenPlayer: { isExpandedPlayerPresented = true })
                case .schedule:
                    ScheduleView()
                case .news:
                    NewsView()
                case .favorites:
                    FavoritesView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Floating Mini Player & Custom Tab Bar
            VStack(spacing: 0) {
                if audioManager.currentStation != nil {
                    MiniPlayerView(onTap: {
                        isExpandedPlayerPresented = true
                    })
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .fullScreenCover(isPresented: $isExpandedPlayerPresented) {
            ExpandedPlayerView(isPresented: $isExpandedPlayerPresented)
        }
    }
}
