//
//  LiveRadioActivity.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveRadioAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var stationName: String
        var programTitle: String
        var presenterName: String
        var isPlaying: Bool
    }
    
    var stationId: String
}

struct LiveRadioActivityView: View {
    let state: LiveRadioAttributes.ContentState
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "radio.fill")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.accentOrange)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(state.stationName)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                Text(state.programTitle)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Circle()
                    .fill(Color.liveRed)
                    .frame(width: 6, height: 6)
                Text("LIVE")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.liveRed)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.liveRed.opacity(0.2))
            .cornerRadius(4)
        }
        .padding()
        .background(Color.darkSurface)
    }
}
