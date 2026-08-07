//
//  UserProfile.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

struct UserProfile: Identifiable, Codable, Equatable {
    let id: String
    var fullName: String
    var email: String
    var avatarUrl: String?
    var role: UserRole
    var favoriteStationId: String?
    var totalListeningMinutes: Int
    var createdAt: Date
    
    enum UserRole: String, Codable {
        case user = "user"
        case presenter = "presenter"
        case admin = "admin"
    }
    
    static var mockGuest: UserProfile {
        UserProfile(
            id: "guest-user",
            fullName: "Guest Listener",
            email: "guest@awradio.com",
            avatarUrl: nil,
            role: .user,
            favoriteStationId: "station-01",
            totalListeningMinutes: 142,
            createdAt: Date()
        )
    }
}
