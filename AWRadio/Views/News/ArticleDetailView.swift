//
//  ArticleDetailView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header Image with Back Button
                    ZStack(alignment: .topLeading) {
                        AsyncImage(url: URL(string: article.imageUrl)) { phase in
                            if let img = phase.image {
                                img.resizable().aspectRatio(contentMode: .fill)
                            } else {
                                Color.royalBlueDark
                            }
                        }
                        .frame(height: 280)
                        .clipped()
                        
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.backward.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                        }
                        .padding(.leading, 16)
                        .padding(.top, 48)
                    }
                    
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text(article.category.uppercased())
                                .font(DesignSystem.Typography.badge)
                                .foregroundColor(.accentOrange)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.accentOrange.opacity(0.15))
                                .cornerRadius(6)
                            
                            Spacer()
                            
                            Text("\(article.readTimeMinutes) min read")
                                .font(DesignSystem.Typography.caption)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Text(article.title)
                            .font(DesignSystem.Typography.title1)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text("By \(article.author)")
                                .font(DesignSystem.Typography.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                            Text("•")
                                .foregroundColor(.white.opacity(0.4))
                            Text(article.publishedAt.formattedDateString())
                                .font(DesignSystem.Typography.subheadline)
                                .foregroundColor(.white.opacity(0.6))
                        }
                        
                        Divider()
                            .background(Color.white.opacity(0.15))
                        
                        Text(article.content)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(6)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}
