//
//  StopwatchCard.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI

struct StopwatchCardView: View {
    @Binding var stopwatch: Stopwatch

    let onStartPause: () -> Void
    let onLap: () -> Void
    let onReset: () -> Void
    let onRest: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            StopwatchHeaderView(stopwatch: $stopwatch)
            StopwatchControlsView(
                isRunning: stopwatch.isRunning,
                onStartPause: onStartPause,
                onLap: onLap,
                onRest: onRest,
                onReset: onReset
            )
            LapsScrollView(laps: stopwatch.laps)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


