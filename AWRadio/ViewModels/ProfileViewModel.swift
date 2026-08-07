//
//  ProfileViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile.mockGuest
    @Published var isShowingImagePicker: Bool = false
    
    init() {
        if let current = AuthManager.shared.currentUser {
            self.userProfile = current
        }
    }
    
    func signOut() {
        AuthManager.shared.signOut()
    }
}
