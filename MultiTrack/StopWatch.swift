//
//  StopWatch.swift
//  MultiTrack
//
//  Created by Drew on 1/17/25.
//

import Foundation

struct Stopwatch : Codable {
    var name: String = ""
    var elapsedTime: TimeInterval = 0
    var laps: [Lap] = []
    var isRunning: Bool = false
    var number: Int = 0
    
    public func fullName() -> String {
        "\(name) \(number)"
    }
}

