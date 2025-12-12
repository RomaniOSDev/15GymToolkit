//
//  RestTimer.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct RestTimer: Identifiable, Codable {
    let id: UUID
    var duration: TimeInterval
    var isRunning: Bool
    var remainingTime: TimeInterval
    var type: TimerType
    
    init(id: UUID = UUID(), duration: TimeInterval, isRunning: Bool = false, remainingTime: TimeInterval? = nil, type: TimerType = .simple) {
        self.id = id
        self.duration = duration
        self.isRunning = isRunning
        self.remainingTime = remainingTime ?? duration
        self.type = type
    }
}

enum TimerType: String, CaseIterable, Codable {
    case simple = "Simple"
    case interval = "Interval"
    case hiit = "HIIT"
}



