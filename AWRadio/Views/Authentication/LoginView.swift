//
//  LoginView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isShowingSignUp = false
    @State private var isShowingForgotPassword = false
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 40)
                    
                    // Logo Header
                    ZStack {
                        Circle()
                            .fill(Color.glassGradient)
                            .frame(width: 90, height: 90)
                            .glassCard(cornerRadius: 45)
                        
                        Image(systemName: "radio.fill")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundStyle(LinearGradient.accentGradient)
                    }
                    
                    VStack(spacing: 6) {
                        Text("Sign In to AW Radio")
                            .font(DesignSystem.Typography.title1)
                            .foregroundColor(.white)
                        
                        Text("Access live streams, save favorites & personalized news")
                            .font(DesignSystem.Typography.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    // Error Message Alert
                    if let error = viewModel.errorMessage {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.accentOrange)
                            Text(error)
                                .font(DesignSystem.Typography.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Input Card
                    GlassCard {
                        VStack(spacing: 16) {
                            // Email Field
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.accentOrange)
                                TextField("Email Address", text: $viewModel.email)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                            
                            // Password Field
                            HStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.accentOrange)
                                SecureField("Password", text: $viewModel.password)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                            
                            // Forgot Password Button
                            HStack {
                                Spacer()
                                Button(action: {
                                    isShowingForgotPassword = true
                                }) {
                                    Text("Forgot Password?")
                                        .font(DesignSystem.Typography.caption)
                                        .foregroundColor(.accentOrange)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // Sign In Button
                    PrimaryButton(title: "Sign In", iconName: "arrow.right.circle.fill", isLoading: viewModel.isLoading) {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                    .padding(.horizontal)
                    
                    // Apple Sign In Button Mock
                    Button(action: {
                        HapticsManager.shared.impact(style: .medium)
                        Task {
                            viewModel.email = "apple.user@awradio.com"
                            viewModel.password = "pass123"
                            await viewModel.signIn()
                        }
                    }) {
                        HStack {
                            Image(systemName: "apple.logo")
                                .font(.system(size: 18, weight: .semibold))
                            Text("Continue with Apple")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    // Continue as Guest Button
                    Button(action: {
                        HapticsManager.shared.selectionChanged()
                        viewModel.continueAsGuest()
                    }) {
                        Text("Continue as Guest")
                            .font(DesignSystem.Typography.headline)
                            .foregroundColor(.white.opacity(0.8))
                            .underline()
                    }
                    .padding(.top, 8)
                    
                    // Sign Up Navigation Link
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white.opacity(0.7))
                        Button(action: {
                            isShowingSignUp = true
                        }) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.accentOrange)
                        }
                    }
                    .font(DesignSystem.Typography.subheadline)
                    .padding(.top, 8)
                    .padding(.bottom, 40)
                }
            }
        }
        .sheet(isPresented: $isShowingSignUp) {
            SignUpView(viewModel: viewModel)
        }
        .sheet(isPresented: $isShowingForgotPassword) {
            ForgotPasswordView()
        }
    }
}
