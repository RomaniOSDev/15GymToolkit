//
//  WorkoutViewModel.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation
import Combine

class WorkoutViewModel: ObservableObject {
    @Published var currentExercise: ExerciseSet?
    @Published var exerciseName: String = ""
    @Published var targetSets: String = "3"
    @Published var repsPerSet: String = "10"
    @Published var weight: String = ""
    
    func createExercise() {
        guard let sets = Int(targetSets),
              let reps = Int(repsPerSet) else { return }
        
        let weightValue = Double(weight.isEmpty ? "0" : weight) ?? nil
        
        currentExercise = ExerciseSet(
            exerciseName: exerciseName.isEmpty ? "Exercise" : exerciseName,
            targetSets: sets,
            completedSets: 0,
            repsPerSet: reps,
            weight: weightValue
        )
    }
    
    func addSet() {
        guard var exercise = currentExercise else { return }
        exercise.completedSets += 1
        currentExercise = exercise
    }
    
    func resetExercise() {
        currentExercise = nil
        exerciseName = ""
        targetSets = "3"
        repsPerSet = "10"
        weight = ""
    }
    
    func getProgress() -> Double {
        guard let exercise = currentExercise else { return 0 }
        return Double(exercise.completedSets) / Double(exercise.targetSets)
    }
}



