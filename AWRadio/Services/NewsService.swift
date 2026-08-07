//
//  NewsService.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

final class NewsService {
    static let shared = NewsService()
    
    private init() {}
    
    func fetchArticles() async -> [NewsArticle] {
        return NewsArticle.mockList
    }
    
    func fetchFeaturedArticle() async -> NewsArticle? {
        return NewsArticle.mockList.first
    }
}
