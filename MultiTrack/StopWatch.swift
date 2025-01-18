//
//  StopWatch.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import Foundation

struct Stopwatch {
    var name: String = "timer"
    var elapsedTime: TimeInterval = 0
    var laps: [TimeInterval] = []
    var isRunning: Bool = false
}
