//
//  SplashView.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import SwiftUI

struct SplashView: View {
    @State private var isAnimating: Bool = false
    @State private var waveOffset: CGFloat = 0
    let onFinished: () -> Void
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            
            // Soft Radial Background Glow
            RadialGradient(
                colors: [Color.royalBlueLight.opacity(0.35), Color.clear],
                center: .center,
                startRadius: 20,
                endRadius: 280
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // AW Radio Logo Icon
                ZStack {
                    Circle()
                        .fill(Color.glassGradient)
                        .frame(width: 140, height: 140)
                        .glassCard(cornerRadius: 70, borderOpacity: 0.3)
                        .shadow(color: Color.royalBlueLight.opacity(0.4), radius: 20, x: 0, y: 10)
                    
                    Image(systemName: "radio.fill")
                        .font(.system(size: 64, weight: .bold))
                        .foregroundStyle(
                            LinearGradient.accentGradient
                        )
                        .scaleEffect(isAnimating ? 1.05 : 0.95)
                }
                
                VStack(spacing: 8) {
                    Text("AW RADIO")
                        .font(.system(size: 32, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(3)
                    
                    Text("Listen Live. Anytime. Anywhere.")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                // Animated Audio Waveform
                HStack(spacing: 6) {
                    ForEach(0..<7) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(LinearGradient.accentGradient)
                            .frame(width: 4, height: isAnimating ? CGFloat.random(in: 16...48) : 12)
                            .animation(
                                Animation.easeInOut(duration: 0.5)
                                    .repeatForever()
                                    .delay(Double(index) * 0.1),
                                value: isAnimating
                            )
                    }
                }
                .padding(.top, 16)
                
                Spacer()
                
                ProgressView()
                    .tint(.accentOrange)
                    .scaleEffect(1.2)
                    .padding(.bottom, 48)
            }
        }
        .onAppear {
            isAnimating = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                withAnimation(.easeOut(duration: 0.5)) {
                    onFinished()
                }
            }
        }
    }
}
