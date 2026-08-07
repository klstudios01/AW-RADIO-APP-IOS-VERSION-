//
//  NewsViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var featuredArticle: NewsArticle?
    @Published var selectedCategory: String = "All"
    @Published var isLoading: Bool = false
    
    let categories = ["All", "Technology", "Entertainment", "Education", "Gospel", "Sports"]
    private let newsService = NewsService.shared
    
    func loadNews() async {
        isLoading = true
        let fetched = await newsService.fetchArticles()
        self.articles = fetched
        self.featuredArticle = fetched.first
        isLoading = false
    }
    
    var filteredArticles: [NewsArticle] {
        if selectedCategory == "All" {
            return articles
        }
        return articles.filter { $0.category.lowercased() == selectedCategory.lowercased() }
    }
}
