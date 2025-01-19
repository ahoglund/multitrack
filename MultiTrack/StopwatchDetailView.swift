//
//  StopwatchDetailView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//
import SwiftUI
import CoreData

struct StopwatchDetailView: View {
    let stopwatch: Stopwatch
    let formattedTime: (TimeInterval) -> String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Stopwatch: \(stopwatch.name.isEmpty ? "Untitled" : stopwatch.name)")
                .font(.subheadline)
                .bold()

            Text("Elapsed Time: \(formattedTime(stopwatch.elapsedTime))")

            if !stopwatch.laps.isEmpty {
                Text("Laps:")
                    .font(.subheadline)
                    .bold()

                ForEach(stopwatch.laps.indices, id: \.self) { lapIndex in
                    HStack {
                        Text("Lap \(lapIndex + 1)")
                        Spacer()
                        Text(formattedTime(stopwatch.laps[lapIndex].elapsedTime))
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

