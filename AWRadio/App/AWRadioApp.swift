//
//  AWRadioApp.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

@main
struct AWRadioApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var authManager = AuthManager.shared
    @State private var showSplash: Bool = true
    @State private var hasCompletedOnboarding: Bool = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplash {
                    SplashView {
                        showSplash = false
                    }
                } else if !hasCompletedOnboarding {
                    OnboardingView {
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        hasCompletedOnboarding = true
                    }
                } else if !authManager.isAuthenticated {
                    LoginView()
                } else {
                    MainContainerView()
                        .preferredColorScheme(.dark)
                }
            }
        }
    }
}
