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
            .navigationTitle("MultiTrack")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Stopwatch") {
                        viewModel.addStopwatch()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save Session") {
                        viewModel.saveSession(context: context)
                    }
                }
            }
        }
    }
}
