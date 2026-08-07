//
//  APIEndpoint.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

enum APIEndpoint {
    case stations
    case programs
    case news
    case podcasts
    case favorites(userId: String)
    case userProfile(userId: String)
    
    var path: String {
        switch self {
        case .stations:
            return "stations?select=*"
        case .programs:
            return "programs?select=*"
        case .news:
            return "news?select=*&order=created_at.desc"
        case .podcasts:
            return "podcasts?select=*"
        case .favorites(let userId):
            return "favorites?user_id=eq.\(userId)"
        case .userProfile(let userId):
            return "users?id=eq.\(userId)"
        }
    }
}
