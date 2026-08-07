//
//  OnboardingView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let iconName: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @State private var currentPage: Int = 0
    let onComplete: () -> Void
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            iconName: "antenna.radiowaves.left.and.right",
            title: "Welcome to AW Radio",
            description: "Discover live radio streams, daily praise, breaking news, and educational broadcasts from anywhere in the world."
        ),
        OnboardingPage(
            iconName: "play.circle.fill",
            title: "Listen Anytime",
            description: "Enjoy uninterrupted high-fidelity streaming, background audio controls, AirPlay integration, and sleep timer."
        ),
        OnboardingPage(
            iconName: "bell.badge.fill",
            title: "Stay Connected",
            description: "Never miss your favorite hosts! Receive push notifications when special events and live shows begin."
        )
    ]
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack {
                // Top Header with Skip Button
                HStack {
                    Spacer()
                    if currentPage < pages.count - 1 {
                        Button(action: {
                            HapticsManager.shared.selectionChanged()
                            onComplete()
                        }) {
                            Text("Skip")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        .padding()
                    }
                }
                
                // TabView Carousel
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 32) {
                            Spacer()
                            
                            // Glass Icon Container
                            ZStack {
                                Circle()
                                    .fill(Color.glassGradient)
                                    .frame(width: 160, height: 160)
                                    .glassCard(cornerRadius: 80, borderOpacity: 0.3)
                                
                                Image(systemName: pages[index].iconName)
                                    .font(.system(size: 72, weight: .bold))
                                    .foregroundStyle(LinearGradient.accentGradient)
                            }
                            
                            VStack(spacing: 16) {
                                Text(pages[index].title)
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text(pages[index].description)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(.white.opacity(0.75))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                                    .lineSpacing(4)
                            }
                            
                            Spacer()
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // Page Indicator Dots
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(currentPage == index ? Color.accentOrange : Color.white.opacity(0.2))
                            .frame(width: currentPage == index ? 24 : 8, height: 8)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 24)
                
                // Bottom Button
                PrimaryButton(
                    title: currentPage == pages.count - 1 ? "Get Started" : "Next",
                    iconName: currentPage == pages.count - 1 ? "arrow.right.circle.fill" : "chevron.right"
                ) {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        onComplete()
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}
