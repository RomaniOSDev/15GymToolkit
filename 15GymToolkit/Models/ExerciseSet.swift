//
//  ExerciseSet.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct ExerciseSet: Identifiable, Codable {
    let id: UUID
    var exerciseName: String
    var targetSets: Int
    var completedSets: Int
    var repsPerSet: Int
    var weight: Double?
    
    init(id: UUID = UUID(), exerciseName: String, targetSets: Int, completedSets: Int = 0, repsPerSet: Int, weight: Double? = nil) {
        self.id = id
        self.exerciseName = exerciseName
        self.targetSets = targetSets
        self.completedSets = completedSets
        self.repsPerSet = repsPerSet
        self.weight = weight
    }
}



