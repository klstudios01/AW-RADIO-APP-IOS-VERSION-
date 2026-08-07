//
//  SupabaseClientManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import Combine

final class SupabaseClientManager {
    static let shared = SupabaseClientManager()
    
    // Replace with your actual Supabase URL & Anon Key or load from Info.plist
    var supabaseUrl: String = "https://your-project-id.supabase.co"
    var supabaseAnonKey: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
    
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
