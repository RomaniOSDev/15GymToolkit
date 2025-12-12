//
//  AppState.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct AppState: Codable {
    var currentTimer: RestTimer?
    var currentExercise: ExerciseSet?
    var recentCalculations: [BarbellCalculation]
    var conversionHistory: [UnitConversion]
    var hasCompletedOnboarding: Bool
    
    init(currentTimer: RestTimer? = nil,
         currentExercise: ExerciseSet? = nil,
         recentCalculations: [BarbellCalculation] = [],
         conversionHistory: [UnitConversion] = [],
         hasCompletedOnboarding: Bool = false) {
        self.currentTimer = currentTimer
        self.currentExercise = currentExercise
        self.recentCalculations = recentCalculations
        self.conversionHistory = conversionHistory
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }
}



