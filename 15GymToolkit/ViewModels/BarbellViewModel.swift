//
//  BarbellViewModel.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation
import Combine

class BarbellViewModel: ObservableObject {
    @Published var targetWeight: String = ""
    @Published var barWeight: Double = 20.0
    @Published var availablePlates: [Plate] = defaultPlates
    @Published var calculatedPlates: [Plate] = []
    @Published var recentCalculations: [BarbellCalculation] = []
    
    init() {
        loadRecentCalculations()
    }
    
    func calculatePlates() {
        guard let target = Double(targetWeight) else { return }
        
        let plates = calculatePlates(
            targetWeight: target,
            barWeight: barWeight,
            availablePlates: availablePlates
        )
        
        calculatedPlates = plates
        
        let calculation = BarbellCalculation(
            targetWeight: target,
            barWeight: barWeight,
            availablePlates: availablePlates,
            calculatedPlates: plates
        )
        
        recentCalculations.insert(calculation, at: 0)
        if recentCalculations.count > 10 {
            recentCalculations.removeLast()
        }
        
        saveRecentCalculations()
    }
    
    private func calculatePlates(targetWeight: Double, barWeight: Double, availablePlates: [Plate]) -> [Plate] {
        var remainingWeight = targetWeight - barWeight
        var result: [Plate] = []
        var plateCounts: [Double: Int] = [:]
        
        // Create a copy of available plates with counts
        var availableCounts: [Double: Int] = [:]
        for plate in availablePlates {
            availableCounts[plate.weight] = plate.count
        }
        
        let sortedPlates = availablePlates.sorted { $0.weight > $1.weight }
        
        for plate in sortedPlates {
            let plateWeight = plate.weight * 2 // Plates on both sides
            
            while remainingWeight >= plateWeight {
                let currentAvailable = availableCounts[plate.weight] ?? 0
                if currentAvailable <= 0 {
                    break
                }
                
                plateCounts[plate.weight, default: 0] += 1
                availableCounts[plate.weight] = currentAvailable - 1
                remainingWeight -= plateWeight
            }
        }
        
        // Convert to Plate array
        for (weight, count) in plateCounts {
            result.append(Plate(weight: weight, count: count))
        }
        
        return result.sorted { $0.weight > $1.weight }
    }
    
    func getTotalWeight() -> Double {
        let platesWeight = calculatedPlates.reduce(0.0) { $0 + ($1.weight * Double($1.count) * 2) }
        return barWeight + platesWeight
    }
    
    private func saveRecentCalculations() {
        if let encoded = try? JSONEncoder().encode(recentCalculations) {
            UserDefaults.standard.set(encoded, forKey: "recentCalculations")
        }
    }
    
    private func loadRecentCalculations() {
        if let data = UserDefaults.standard.data(forKey: "recentCalculations"),
           let decoded = try? JSONDecoder().decode([BarbellCalculation].self, from: data) {
            recentCalculations = decoded
        }
    }
}

let defaultPlates: [Plate] = [
    Plate(weight: 25, count: 4),
    Plate(weight: 20, count: 4),
    Plate(weight: 15, count: 4),
    Plate(weight: 10, count: 4),
    Plate(weight: 5, count: 4),
    Plate(weight: 2.5, count: 4),
    Plate(weight: 1.25, count: 4)
]

