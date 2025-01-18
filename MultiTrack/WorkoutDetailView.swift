//
//  WorkoutDetailView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//
import SwiftUI
import CoreData

struct WorkoutDetailView: View {
    let workout: Workout  // The workout we're showing
    
    // We'll decode the [Stopwatch] from the workout's stopwatchesData
    @State private var decodedStopwatches: [Stopwatch] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 1) Show date
            if let date = workout.date {
                Text("Date: \(date, formatter: detailDateFormatter)")
                    .font(.headline)
            }
            
            // 2) For each stopwatch, show name & laps
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(decodedStopwatches.indices, id: \.self) { index in
                        let sw = decodedStopwatches[index]
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stopwatch: \(sw.name.isEmpty ? "Untitled" : sw.name)")
                                .font(.subheadline)
                                .bold()
                            
                            Text("Elapsed Time: \(formattedTime(sw.elapsedTime))")
                            
                            if !sw.laps.isEmpty {
                                Text("Laps:")
                                    .font(.subheadline)
                                    .bold()
                                ForEach(sw.laps.indices, id: \.self) { lapIndex in
                                    HStack {
                                        Text("Lap \(lapIndex + 1)")
                                        Spacer()
                                        Text(formattedTime(sw.laps[lapIndex]))
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
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
    
    // MARK: - Decode [Stopwatch]
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

