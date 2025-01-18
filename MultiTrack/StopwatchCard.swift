//
//  StopwatchCard.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI

struct StopwatchCard: View {
    // Use a binding so changes propagate back to the parent
    @Binding var stopwatch: Stopwatch
    let onStartPause: () -> Void
    let onLap: () -> Void
    let onReset: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            // 1) NAME/TITLE FIELD

                TextField("Edit Name", text: $stopwatch.name)
                    .font(.subheadline)
                    .padding(.vertical, 4)
                    .textFieldStyle(PlainTextFieldStyle())
                    .multilineTextAlignment(.leading)
                Text(formattedTime(stopwatch.elapsedTime))
                    .font(.system(size: 36, weight: .light, design: .monospaced))
                    .multilineTextAlignment(.trailing)

            HStack {
                // Start/Pause button
                Button(action: {
                    onStartPause()
                }) {
                    Text(stopwatch.isRunning ? "Pause" : "Start")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(stopwatch.isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                // Lap
                Button(action: {
                    onLap()
                }) {
                    Text("Lap")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                
                // Reset
                Button(action: {
                    onReset()
                }) {
                    Text("Reset")
                        .font(.subheadline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            
            // Display laps if you want
            if !stopwatch.laps.isEmpty {
                Text("Laps:")
                    .font(.headline)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(stopwatch.laps.indices, id: \.self) { i in
                            HStack {
                                // Left-aligned "Lap N"
                                Text("Lap \(i + 1)")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                // Right-aligned lap time
                                Text(formattedTime(stopwatch.laps[i]))
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                            }
                            .padding(.vertical, 6)
                            
                            // Thin line separator
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
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
    
    // Format time as mm:ss
    private func formattedTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        let milliseconds = Int((interval - floor(interval)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}
