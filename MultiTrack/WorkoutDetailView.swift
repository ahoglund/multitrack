//
//  WorkoutDetailView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//
import SwiftUI
import CoreData

struct WorkoutDetailView: View {
    let workout: Workout      // from Core Data
    @State private var decodedStopwatches: [Stopwatch] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 1) Show date
            if let date = workout.date {
                Text("Date: \(date, formatter: detailDateFormatter)")
                    .font(.headline)
            }

            // 2) Show each stopwatch in a scrollable list
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(decodedStopwatches.indices, id: \.self) { index in
                        StopwatchDetailView(
                            stopwatch: decodedStopwatches[index],
                            formattedTime: formattedTime
                        )
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Workout Details")
        .onAppear {
            decodeStopwatches()
        }
    }

    // MARK: - Decode [Stopwatch] from workout.stopwatchesData
    private func decodeStopwatches() {
        guard let jsonString = workout.stopwatchesData,
              let data = jsonString.data(using: .utf8) else {
            return
        }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Stopwatch].self, from: data)
            decodedStopwatches = result
        } catch {
            print("Failed to decode stopwatches:", error)
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

private let detailDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    return formatter
}()


