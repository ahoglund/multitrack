//
//  WorkoutsView.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//
import SwiftUI
import CoreData

struct WorkoutsView: View {
    // Fetch all workouts from Core Data
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)]
    ) var workouts: FetchedResults<Workout>
    
    var body: some View {
        List {
            ForEach(workouts, id: \.self) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    // Show date (and optionally more info)
                    if let workoutDate = workout.date {
                        Text("\(workoutDate, formatter: dateFormatter)")
                    } else {
                        Text("Unknown Date")
                    }
                }
            }
        }
        .navigationTitle("All Workouts")
    }
}

// A DateFormatter for displaying dates
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
