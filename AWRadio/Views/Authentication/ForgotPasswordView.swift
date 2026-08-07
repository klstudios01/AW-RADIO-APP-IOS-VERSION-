//
//  ForgotPasswordView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var isSubmitted: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Spacer()
                }
                .padding()
                
                VStack(spacing: 8) {
                    Text("Reset Password")
                        .font(DesignSystem.Typography.title1)
                        .foregroundColor(.white)
                    Text("Enter your account email to receive a password reset link.")
                        .font(DesignSystem.Typography.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                if isSubmitted {
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.statusGreen)
                        Text("Reset Link Sent!")
                            .font(DesignSystem.Typography.title2)
                            .foregroundColor(.white)
                        Text("Check your email inbox for instructions to reset your password.")
                            .font(DesignSystem.Typography.body)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                } else {
                    GlassCard {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.accentOrange)
                            TextField("Account Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    PrimaryButton(title: "Send Reset Link", iconName: "paperplane.fill") {
                        withAnimation {
                            isSubmitted = true
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}
