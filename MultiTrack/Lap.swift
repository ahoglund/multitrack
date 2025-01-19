//
//  Lap.swift
//  MultiTrack
//
//  Created by Drew on 1/18/25.
//

import Foundation

struct Lap: Codable {
    var startTime: TimeInterval = 0
    var endTime: TimeInterval = 0
    var isRest: Bool = false
}
