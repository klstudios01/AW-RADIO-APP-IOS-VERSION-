//
//  CustomTabBar.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

enum TabItem: Int, CaseIterable, Identifiable {
    case home = 0
    case live = 1
    case schedule = 2
    case news = 3
    case favorites = 4
    case profile = 5
    
    var id: Int { self.rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .live: return "Live"
        case .schedule: return "Schedule"
        case .news: return "News"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .live: return "radio.fill"
        case .schedule: return "calendar.badge.clock"
        case .news: return "newspaper.fill"
        case .favorites: return "heart.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack {
            ForEach(TabItem.allCases) { tab in
                Spacer()
                
                Button(action: {
                    HapticsManager.shared.selectionChanged()
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: tab == .live ? 22 : 18, weight: selectedTab == tab ? .bold : .medium))
                            .scaleEffect(selectedTab == tab ? 1.15 : 1.0)
                        
                        Text(tab.title)
                            .font(.system(size: 10, weight: selectedTab == tab ? .bold : .regular))
                    }
                    .foregroundColor(selectedTab == tab ? .accentOrange : .white.opacity(0.6))
                    .padding(.vertical, 8)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 12)
        .padding(.top, 8)
        .background(
            Color.darkBackground.opacity(0.92)
                .background(VisualEffectBlur(blurStyle: .systemMaterialDark))
        )
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.white.opacity(0.12)),
            alignment: .top
        )
    }
}
