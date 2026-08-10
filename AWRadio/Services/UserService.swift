//
//  UserService.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation

@MainActor
final class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func fetchProfile(id: String) async -> UserProfile {
        return UserProfile.mockGuest
    }
}
