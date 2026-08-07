//
//  AuthViewModel.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI
import Combine

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var fullName = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authManager = AuthManager.shared
    
    func signIn() async {
        isLoading = true
        errorMessage = nil
        let success = await authManager.signIn(email: email, password: password)
        isLoading = false
        if !success {
            errorMessage = authManager.authError ?? "Sign in failed"
        }
    }
    
    func signUp() async {
        isLoading = true
        errorMessage = nil
        let success = await authManager.signUp(name: fullName, email: email, password: password)
        isLoading = false
        if !success {
            errorMessage = authManager.authError ?? "Sign up failed"
        }
    }
    
    func continueAsGuest() {
        authManager.continueAsGuest()
    }
}
