//
//  StopwatchesViewModel.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import SwiftUI
import Combine
import CoreData

class StopwatchesViewModel: ObservableObject {
    @Published var stopwatches: [Stopwatch] = []
    
    private var timerCancellable: AnyCancellable?
    private var lastUpdateTime: Date?
    
    init() {
        var stopwatch = Stopwatch()
        stopwatch.name = "Stopwatch 1"
        stopwatch.number = 1
        stopwatches = [stopwatch]
    }
    
    func startStopwatch(at index: Int) {
        guard index < stopwatches.count else { return }
        // If it’s already running, do nothing
        if stopwatches[index].isRunning { return }
        
        // Mark it running
        stopwatches[index].isRunning = true
        
        // If no global timer is active, start one
        if timerCancellable == nil {
            lastUpdateTime = Date()
            // Update 10 times/sec
            timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.updateStopwatches()
                }
        }
    }
    
    func pauseStopwatch(at index: Int) {
        guard index < stopwatches.count else { return }
        stopwatches[index].isRunning = false
        
        // If no other stopwatch is running, cancel the timer
        if stopwatches.allSatisfy({ !$0.isRunning }) {
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
    
    func resetStopwatch(at index: Int) {
        guard index < stopwatches.count else { return }
        guard stopwatches[index].isRunning else { return }
        stopwatches[index].elapsedTime = 0
        stopwatches[index].laps.removeAll()
        stopwatches[index].isRunning = false
        
        // If no other stopwatch is running, cancel the timer
        if stopwatches.allSatisfy({ !$0.isRunning }) {
            timerCancellable?.cancel()
            timerCancellable = nil
        }
    }
    
    func lapStopwatch(at index: Int, rest: Bool) {
        guard index < stopwatches.count else { return }
        guard stopwatches[index].isRunning else { return }
        stopwatches[index].laps.append(Lap(elapsedTime: stopwatches[index].elapsedTime, isRest: rest))
    }
    
    // Add a new stopwatch
    func addStopwatch(index: Int) {
        stopwatches.append(Stopwatch(name: "Stopwatch \(index + 1)", number: index + 1))
    }
    
    func endWorkout() {
        // stop all stopwatches
        for i in stopwatches.indices where stopwatches[i].isRunning {
            stopwatches[i].isRunning = false
        }
    }
    
    // Update time for all running stopwatches
    private func updateStopwatches() {
        guard let lastTime = lastUpdateTime else { return }
        let now = Date()
        let delta = now.timeIntervalSince(lastTime)
        lastUpdateTime = now
        
        for i in stopwatches.indices where stopwatches[i].isRunning {
            stopwatches[i].elapsedTime += delta
        }
    }
    
    func saveWorkout(context: NSManagedObjectContext) {
        endWorkout()
        let workout = Workout(context: context)
        workout.id = UUID()
        workout.date = Date()
        workout.name = "Workout"
        
        do {
            let encoder = JSONEncoder()
            // You can encode the entire array of Stopwatches
            let data = try encoder.encode(stopwatches)
            workout.stopwatchesData = String(data: data, encoding: .utf8)
            
            // 3) Save to persistent store
            try context.save()
            print("Workout saved.")
        } catch {
            print("Failed to encode or save workout:", error)
        }
    }
}
