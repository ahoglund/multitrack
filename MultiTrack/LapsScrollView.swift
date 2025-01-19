//
//  LapsScrollView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//

import SwiftUI

struct LapsScrollView: View {
    let laps: [Lap]
    
    var body: some View {
        if !laps.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text("Laps:")
                    .font(.headline)

                ScrollView {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Type")
                                .font(.caption)
                            Spacer()
                            Text("Duration")
                                .font(.caption)
                            Spacer()
                            Text("Ended At")
                                .font(.caption)
                        }
                        ForEach(laps.indices.reversed(), id: \.self) { i in
                            HStack {
                                Text("\(laps[i].isRest ? "Rest" : "Lap") \(i + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text(formattedTime(laps[i].endTime - laps[i].startTime))
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                Spacer()
                                // Right-aligned lap time
                                Text(formattedTime(laps[i].endTime))
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            .padding(.vertical, 6)
                            Divider()
                        }
                    }
                    .padding(.horizontal, 4)  // some inner padding
                }
                .frame(height: 80) // Fixed height for laps section
                .cornerRadius(8)
                .shadow(radius: 1)
            }
        }
    }

    // MARK: - Time Formatting
    private func formattedTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval - floor(interval)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}
