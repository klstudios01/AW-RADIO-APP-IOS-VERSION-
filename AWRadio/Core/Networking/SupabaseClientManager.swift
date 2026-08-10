//
//  SupabaseClientManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import Combine

@MainActor
final class SupabaseClientManager {
    static let shared = SupabaseClientManager()
    
    // Configured Supabase URL & Anon Key
    var supabaseUrl: String = "https://sivtufqdhvfmllpdxute.supabase.co"
    var supabaseAnonKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNpdnR1ZnFkaHZmbWxscGR4dXRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODYzNjUzMjQsImV4cCI6MjEwMTk0MTMyNH0.UPWXSwJ6CA4HwtxbED_Ib_s1OSXh7xGR8rjgZcE4oHA"
    
    private init() {}
    
    func configure(url: String, anonKey: String) {
        self.supabaseUrl = url
        self.supabaseAnonKey = anonKey
    }
    
    func makeRequest(endpoint: String, method: String = "GET", body: Data? = nil, headers: [String: String] = [:]) -> URLRequest? {
        guard let url = URL(string: "\(supabaseUrl)/rest/v1/\(endpoint)") else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue(supabaseAnonKey, forHTTPHeaderField: "apikey")
        request.addValue("Bearer \(supabaseAnonKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
}
