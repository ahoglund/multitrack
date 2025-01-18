//
//  ContentView.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    // We’ll create an @StateObject for our view model that holds multiple stopwatches
    @StateObject private var viewModel = StopwatchesViewModel()
    
    // For layout, define columns for LazyVGrid
    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .trailing,spacing: 10) {
                    Button("Add Stopwatch") {
                        viewModel.addStopwatch()
                    }.buttonStyle(.bordered)
                }
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.stopwatches.indices, id: \.self) { index in
                        StopwatchCard(
                            stopwatch: $viewModel.stopwatches[index],
                            onStartPause: {
                                if viewModel.stopwatches[index].isRunning {
                                    viewModel.pauseStopwatch(at: index)
                                } else {
                                    viewModel.startStopwatch(at: index)
                                }
                            },
                            onLap: {
                                viewModel.lapStopwatch(at: index)
                            },
                            onReset: {
                                viewModel.resetStopwatch(at: index)
                            }
                        )
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save Workout") {
                        viewModel.saveWorkout(context: context)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("View Workouts") {
                        viewModel.saveWorkout(context: context)
                    }
                }
            }
        }
    }
}
