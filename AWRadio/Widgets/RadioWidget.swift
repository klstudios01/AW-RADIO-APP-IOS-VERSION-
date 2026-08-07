//
//  RadioWidget.swift
//  AW Radio
//
//  Created for AW Radio iOS Application.
//

import WidgetKit
import SwiftUI

struct RadioWidgetEntry: TimelineEntry {
    let date: Date
    let stationName: String
    let programTitle: String
    let presenterName: String
}

struct RadioWidgetEntryView: View {
    var entry: RadioWidgetEntry
    
    var body: some View {
        ZStack {
            Color.darkBackground
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "radio.fill")
                        .foregroundColor(.accentOrange)
                    Text("AW RADIO")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                    Circle()
                        .fill(Color.liveRed)
                        .frame(width: 6, height: 6)
                }
                
                Spacer()
                
                Text(entry.stationName)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                
                Text(entry.programTitle)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                
                Text("Host: \(entry.presenterName)")
                    .font(.system(size: 10))
                    .foregroundColor(.accentOrange)
            }
            .padding(12)
        }
    }
}
