//
//  WorkoutView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Environment(\.managedObjectContext) private var context
    // We’ll create an @StateObject for our view model that holds multiple stopwatches
    @StateObject private var viewModel = StopwatchesViewModel()
    // For layout, define columns for LazyVGrid
    
    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            HStack(alignment:.center,spacing: 10) {
                Button("Add Stopwatch") {
                    viewModel.addStopwatch(index: viewModel.stopwatches.count)
                }.buttonStyle(.bordered)
                Button("Save Workout") {
                    viewModel.saveWorkout(context: context)
                }.buttonStyle(.bordered)
            }
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.stopwatches.indices, id: \.self) { index in
                    StopwatchCardView(
                        stopwatch: $viewModel.stopwatches[index],
                        onStartPause: {
                            if viewModel.stopwatches[index].isRunning {
                                viewModel.pauseStopwatch(at: index)
                            } else {
                                viewModel.startStopwatch(at: index)
                            }
                        },
                        onLap: {
                            viewModel.lapStopwatch(at: index, rest: false)
                        },
                        onReset: {
                            viewModel.resetStopwatch(at: index)
                        },
                        onRest: {
                            viewModel.lapStopwatch(at: index, rest: true)
                        }
                    )
                }
            }
            .padding()
        }
    }
}
