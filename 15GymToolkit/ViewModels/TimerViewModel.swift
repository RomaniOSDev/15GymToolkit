//
//  TimerViewModel.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var timer: RestTimer?
    @Published var timeRemaining: TimeInterval = 0
    @Published var isRunning: Bool = false
    @Published var selectedType: TimerType = .simple
    
    private var timerCancellable: AnyCancellable?
    private var startDate: Date?
    private var initialRemainingTime: TimeInterval = 0
    
    init() {
        setupTimer()
    }
    
    func setupTimer() {
        timer = RestTimer(duration: 60, type: selectedType)
        timeRemaining = timer?.remainingTime ?? 60
        initialRemainingTime = timeRemaining
    }
    
    func startTimer() {
        guard let timer = timer else { return }
        
        if !isRunning {
            initialRemainingTime = timeRemaining
            startDate = Date()
            isRunning = true
            
            timerCancellable = Timer.publish(every: 0.1, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.updateTimer()
                }
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
        
        // Update timer with current remaining time
        if var currentTimer = timer {
            currentTimer.remainingTime = timeRemaining
            timer = currentTimer
        }
    }
    
    func resetTimer() {
        pauseTimer()
        setupTimer()
    }
    
    func setDuration(_ duration: TimeInterval) {
        timer = RestTimer(duration: duration, type: selectedType)
        timeRemaining = duration
        initialRemainingTime = duration
        pauseTimer()
    }
    
    func setTimerType(_ type: TimerType) {
        selectedType = type
        if let timer = timer {
            self.timer = RestTimer(
                id: timer.id,
                duration: timer.duration,
                isRunning: false,
                remainingTime: timeRemaining,
                type: type
            )
        }
    }
    
    private func updateTimer() {
        guard let startDate = startDate else { return }
        
        let elapsed = Date().timeIntervalSince(startDate)
        timeRemaining = max(0, initialRemainingTime - elapsed)
        
        if timeRemaining <= 0 {
            pauseTimer()
            timeRemaining = 0
        }
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

