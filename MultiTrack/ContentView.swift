//
//  ContentView.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = StopwatchesViewModel()
    var body: some View {
        NavigationView {
            ActiveWorkoutView()
        }
        .toolbar {
//            ToolbarItem(placement: .bottomBar) {
//                NavigationLink("New Workout") {
//                    ActiveWorkoutView()
//                }
//            }
            ToolbarItem(placement: .bottomBar) {
                NavigationLink("All Workouts", destination: WorkoutsView())
            }
        }
    }
}
