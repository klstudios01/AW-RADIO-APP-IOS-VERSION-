//
//  SignUpView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: AuthViewModel
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
                    Text("Create Account")
                        .font(DesignSystem.Typography.title1)
                        .foregroundColor(.white)
                    Text("Join AW Radio listener community today")
                        .font(DesignSystem.Typography.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                GlassCard {
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.accentOrange)
                            TextField("Full Name", text: $viewModel.fullName)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(12)
                        
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
                        
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.accentOrange)
                            SecureField("Password", text: $viewModel.password)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                PrimaryButton(title: "Register Account", iconName: "checkmark.circle.fill", isLoading: viewModel.isLoading) {
                    Task {
                        await viewModel.signUp()
                        dismiss()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}
