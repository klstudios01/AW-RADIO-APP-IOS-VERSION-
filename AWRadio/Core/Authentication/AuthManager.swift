//
//  AuthManager.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import Foundation
import Combine

@MainActor
final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    @Published var currentUser: UserProfile?
    @Published var isAuthenticated: Bool = false
    @Published var isGuest: Bool = false
    @Published var authError: String?
    
    private init() {
        // Load cached session or guest mode
        if UserDefaults.standard.bool(forKey: "isGuestUser") {
            self.isGuest = true
            self.currentUser = UserProfile.mockGuest
            self.isAuthenticated = true
        } else if let data = UserDefaults.standard.data(forKey: "currentUser"),
                  let user = try? JSONDecoder().decode(UserProfile.self, from: data) {
            self.currentUser = user
            self.isAuthenticated = true
        }
    }
    
    func signIn(email: String, password: System.String) async -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            self.authError = "Please fill in all email and password fields."
            return false
        }
        
        // Simulating Supabase auth response
        let user = UserProfile(
            id: UUID().uuidString,
            fullName: email.components(separatedBy: "@").first?.capitalized ?? "Listener",
            email: email,
            avatarUrl: nil,
            role: .user,
            favoriteStationId: "station-01",
            totalListeningMinutes: 68,
            createdAt: Date()
        )
        
        self.currentUser = user
        self.isAuthenticated = true
        self.isGuest = false
        self.saveUser(user)
        return true
    }
    
    func signUp(name: String, email: String, password: String) async -> Bool {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            self.authError = "Please fill out all registration fields."
            return false
        }
        
        let user = UserProfile(
            id: UUID().uuidString,
            fullName: name,
            email: email,
            avatarUrl: nil,
            role: .user,
            favoriteStationId: "station-01",
            totalListeningMinutes: 0,
            createdAt: Date()
        )
        
        self.currentUser = user
        self.isAuthenticated = true
        self.isGuest = false
        self.saveUser(user)
        return true
    }
    
    func continueAsGuest() {
        self.isGuest = true
        self.currentUser = UserProfile.mockGuest
        self.isAuthenticated = true
        UserDefaults.standard.set(true, forKey: "isGuestUser")
    }
    
    func signOut() {
        self.currentUser = nil
        self.isAuthenticated = false
        self.isGuest = false
        UserDefaults.standard.removeObject(forKey: "currentUser")
        UserDefaults.standard.set(false, forKey: "isGuestUser")
    }
    
    private func saveUser(_ user: UserProfile) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "currentUser")
            UserDefaults.standard.set(false, forKey: "isGuestUser")
        }
    }
}
