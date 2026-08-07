//
//  FavoritesView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @ObservedObject var audioManager = AudioStreamManager.shared
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header Bar
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("SAVED ITEMS")
                            .font(DesignSystem.Typography.badge)
                            .foregroundColor(.accentOrange)
                            .tracking(1.5)
                        Text("Your Favorites")
                            .font(DesignSystem.Typography.title1)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Segment Picker (Stations / Shows / News)
                Picker("Favorite Type", selection: $viewModel.selectedSegment) {
                    Text("Stations").tag(FavoriteItem.FavoriteType.station)
                    Text("Shows").tag(FavoriteItem.FavoriteType.program)
                    Text("News").tag(FavoriteItem.FavoriteType.news)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // List of Saved Favorites
                if viewModel.filteredFavorites.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "heart.slash.fill")
                            .font(.system(size: 54))
                            .foregroundColor(.white.opacity(0.3))
                        Text("No Saved Favorites Yet")
                            .font(DesignSystem.Typography.title3)
                            .foregroundColor(.white)
                        Text("Tap the heart icon on any station, program, or news article to save it here for offline access.")
                            .font(DesignSystem.Typography.body)
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.filteredFavorites) { favorite in
                                GlassCard(padding: 12) {
                                    HStack(spacing: 14) {
                                        AsyncImage(url: URL(string: favorite.imageUrl)) { phase in
                                            if let img = phase.image {
                                                img.resizable().aspectRatio(contentMode: .fill)
                                            } else {
                                                Color.royalBlueDark
                                            }
                                        }
                                        .frame(width: 54, height: 54)
                                        .cornerRadius(10)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(favorite.title)
                                                .font(DesignSystem.Typography.headline)
                                                .foregroundColor(.white)
                                            Text(favorite.subtitle)
                                                .font(DesignSystem.Typography.caption)
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            viewModel.removeFavorite(id: favorite.itemReferenceId)
                                        }) {
                                            Image(systemName: "heart.fill")
                                                .font(.system(size: 20))
                                                .foregroundColor(.accentOrange)
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
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
