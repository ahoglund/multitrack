//
//  StopwatchHeaderView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//

import SwiftUI

struct StopwatchHeaderView: View {
    @Binding var stopwatch: Stopwatch // We only need the stopwatch name

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Edit Name", text: $stopwatch.name)
                .font(.headline)
                .textFieldStyle(PlainTextFieldStyle())
                .multilineTextAlignment(.leading)

            Text(formattedTime(stopwatch.elapsedTime))
                .font(.system(size: 36, weight: .light, design: .monospaced))
                .multilineTextAlignment(.trailing)
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
