//
//  NewsView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct NewsView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var selectedArticle: NewsArticle?
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Header Bar
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("AW RADIO DESK")
                                .font(DesignSystem.Typography.badge)
                                .foregroundColor(.accentOrange)
                                .tracking(1.5)
                            Text("Latest News")
                                .font(DesignSystem.Typography.title1)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Category Selection Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.categories, id: \.self) { cat in
                                CategoryPill(
                                    title: cat,
                                    isSelected: viewModel.selectedCategory == cat,
                                    action: { viewModel.selectedCategory = cat }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Featured Article Hero Card
                    if let featured = viewModel.featuredArticle {
                        Button(action: {
                            selectedArticle = featured
                        }) {
                            ZStack(alignment: .bottomLeading) {
                                AsyncImage(url: URL(string: featured.imageUrl)) { phase in
                                    if let img = phase.image {
                                        img.resizable().aspectRatio(contentMode: .fill)
                                    } else {
                                        Color.royalBlueDark
                                    }
                                }
                                .frame(height: 200)
                                .clipped()
                                .overlay(
                                    LinearGradient(
                                        colors: [.clear, Color.darkBackground.opacity(0.95)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(featured.category.uppercased())
                                        .font(DesignSystem.Typography.badge)
                                        .foregroundColor(.accentOrange)
                                    
                                    Text(featured.title)
                                        .font(DesignSystem.Typography.title3)
                                        .foregroundColor(.white)
                                        .lineLimit(2)
                                }
                                .padding(16)
                            }
                            .cornerRadius(16)
                            .glassCard(cornerRadius: 16)
                            .padding(.horizontal)
                        }
                    }
                    
                    // News Articles List
                    VStack(spacing: 12) {
                        ForEach(viewModel.filteredArticles) { article in
                            Button(action: {
                                selectedArticle = article
                            }) {
                                GlassCard(padding: 12) {
                                    HStack(spacing: 14) {
                                        AsyncImage(url: URL(string: article.imageUrl)) { phase in
                                            if let img = phase.image {
                                                img.resizable().aspectRatio(contentMode: .fill)
                                            } else {
                                                Color.royalBlueDark
                                            }
                                        }
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(12)
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(article.category.uppercased())
                                                .font(DesignSystem.Typography.badge)
                                                .foregroundColor(.accentOrange)
                                            
                                            Text(article.title)
                                                .font(DesignSystem.Typography.headline)
                                                .foregroundColor(.white)
                                                .lineLimit(2)
                                            
                                            Text(article.publishedAt.formattedRelativeString())
                                                .font(DesignSystem.Typography.caption)
                                                .foregroundColor(.white.opacity(0.6))
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
            await viewModel.loadNews()
        }
        .sheet(item: $selectedArticle) { article in
            ArticleDetailView(article: article)
        }
    }
}
