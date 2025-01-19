//
//  StopwatchControlsView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//

import SwiftUI

struct StopwatchControlsView: View {
    let isRunning: Bool
    let onStartPause: () -> Void
    let onLap: () -> Void
    let onRest: () -> Void
    let onReset: () -> Void

    var body: some View {
        HStack {
            // Start/Pause
            Button(action: onStartPause) {
                Text(isRunning ? "Pause" : "Start")
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }

            // Lap
            Button(action: onLap) {
                Text("Lap")
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray))
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }

            // Rest
            Button(action: onRest) {
                Text("Rest")
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray))
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }

            // Reset
            Button(action: onReset) {
                Text("Reset")
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
        }
    }
}
