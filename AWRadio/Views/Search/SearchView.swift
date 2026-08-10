//
//  SearchView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @ObservedObject var audioManager = AudioStreamManager.shared
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header Bar
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("DISCOVER")
                            .font(DesignSystem.Typography.badge)
                            .foregroundColor(.accentOrange)
                            .tracking(1.5)
                        Text("Search Everything")
                            .font(DesignSystem.Typography.title1)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                // Search Input Box
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.accentOrange)
                    TextField("Search stations, presenters, shows...", text: $viewModel.query)
                        .foregroundColor(.white)
                        .onChange(of: viewModel.query) {
                            viewModel.performSearch()
                        }
                    
                    if !viewModel.query.isEmpty {
                        Button(action: {
                            viewModel.query = ""
                            viewModel.performSearch()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(14)
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        if viewModel.query.isEmpty {
                            // Trending Tags Section
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Trending Topics")
                                    .font(DesignSystem.Typography.title3)
                                    .foregroundColor(.white)
                                
                                FlowLayout(spacing: 8) {
                                    ForEach(viewModel.trendingTags, id: \.self) { tag in
                                        Button(action: {
                                            viewModel.query = tag
                                            viewModel.performSearch()
                                        }) {
                                            Text("#\(tag)")
                                                .font(DesignSystem.Typography.subheadline)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 14)
                                                .padding(.vertical, 8)
                                                .background(Color.royalBlueLight.opacity(0.3))
                                                .cornerRadius(16)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // Recent Searches
                            if !viewModel.recentSearches.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    HStack {
                                        Text("Recent Searches")
                                            .font(DesignSystem.Typography.title3)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Button(action: { viewModel.clearHistory() }) {
                                            Text("Clear")
                                                .font(DesignSystem.Typography.caption)
                                                .foregroundColor(.accentOrange)
                                        }
                                    }
                                    
                                    ForEach(viewModel.recentSearches, id: \.self) { item in
                                        Button(action: {
                                            viewModel.query = item
                                            viewModel.performSearch()
                                        }) {
                                            HStack {
                                                Image(systemName: "clock")
                                                    .foregroundColor(.white.opacity(0.5))
                                                Text(item)
                                                    .foregroundColor(.white.opacity(0.9))
                                                Spacer()
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white.opacity(0.3))
                                            }
                                            .padding(.vertical, 8)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            // Matching Stations Results
                            if !viewModel.matchingStations.isEmpty {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("Stations (\(viewModel.matchingStations.count))")
                                        .font(DesignSystem.Typography.title3)
                                        .foregroundColor(.white)
                                    
                                    ForEach(viewModel.matchingStations) { station in
                                        Button(action: {
                                            audioManager.play(station: station)
                                        }) {
                                            GlassCard(padding: 12) {
                                                HStack(spacing: 12) {
                                                    AsyncImage(url: URL(string: station.logoUrl)) { phase in
                                                        if let img = phase.image {
                                                            img.resizable().aspectRatio(contentMode: .fill)
                                                        } else {
                                                            Color.royalBlueDark
                                                        }
                                                    }
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(10)
                                                    
                                                    VStack(alignment: .leading, spacing: 2) {
                                                        Text(station.name)
                                                            .font(DesignSystem.Typography.headline)
                                                            .foregroundColor(.white)
                                                        Text(station.tagline)
                                                            .font(DesignSystem.Typography.caption)
                                                            .foregroundColor(.white.opacity(0.7))
                                                    }
                                                    Spacer()
                                                    Image(systemName: "play.circle.fill")
                                                        .font(.system(size: 28))
                                                        .foregroundColor(.accentOrange)
                                                }
                                            }
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
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.bounds
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.origins[index].x, y: bounds.minY + result.origins[index].y), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var bounds = CGSize.zero
        var origins = [CGPoint]()

        init(in maxLineWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if currentX + size.width > maxLineWidth {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                origins.append(CGPoint(x: currentX, y: currentY))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }

            bounds = CGSize(width: maxLineWidth, height: currentY + lineHeight)
        }
    }
}
