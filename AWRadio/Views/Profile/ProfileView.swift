//
//  ProfileView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @ObservedObject var authManager = AuthManager.shared
    @State private var isShowingSettings = false
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Top Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("USER PROFILE")
                                .font(DesignSystem.Typography.badge)
                                .foregroundColor(.accentOrange)
                                .tracking(1.5)
                            Text("My Account")
                                .font(DesignSystem.Typography.title1)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        Button(action: {
                            isShowingSettings = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // User Avatar & Name Card
                    GlassCard {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient.brandGradient)
                                    .frame(width: 90, height: 90)
                                
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 80))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            
                            VStack(spacing: 4) {
                                Text(authManager.currentUser?.fullName ?? "Guest Listener")
                                    .font(DesignSystem.Typography.title2)
                                    .foregroundColor(.white)
                                
                                Text(authManager.currentUser?.email ?? "guest@awradio.com")
                                    .font(DesignSystem.Typography.subheadline)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    
                    // Listening Statistics Cards
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Listening Activity")
                            .font(DesignSystem.Typography.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            GlassCard(padding: 14) {
                                VStack(spacing: 8) {
                                    Image(systemName: "clock.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.accentOrange)
                                    Text("\(authManager.currentUser?.totalListeningMinutes ?? 142) mins")
                                        .font(DesignSystem.Typography.title3)
                                        .foregroundColor(.white)
                                    Text("Total Time")
                                        .font(DesignSystem.Typography.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            GlassCard(padding: 14) {
                                VStack(spacing: 8) {
                                    Image(systemName: "radio.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.royalBlueLight)
                                    Text("Main Stream")
                                        .font(DesignSystem.Typography.title3)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                    Text("Top Station")
                                        .font(DesignSystem.Typography.caption)
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Account Options List
                    VStack(spacing: 12) {
                        Button(action: {
                            isShowingSettings = true
                        }) {
                            GlassCard(padding: 14) {
                                HStack {
                                    Image(systemName: "sliders.horizontal.3")
                                        .foregroundColor(.accentOrange)
                                    Text("App Preferences & Settings")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white.opacity(0.4))
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.signOut()
                        }) {
                            GlassCard(padding: 14) {
                                HStack {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .foregroundColor(.liveRed)
                                    Text("Sign Out")
                                        .foregroundColor(.liveRed)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 120)
                }
            }
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
    }
}
