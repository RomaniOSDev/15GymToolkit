//
//  BarbellCalculation.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct BarbellCalculation: Identifiable, Codable {
    let id: UUID
    var targetWeight: Double
    var barWeight: Double
    var availablePlates: [Plate]
    var calculatedPlates: [Plate]?
    
    init(id: UUID = UUID(), targetWeight: Double, barWeight: Double, availablePlates: [Plate], calculatedPlates: [Plate]? = nil) {
        self.id = id
        self.targetWeight = targetWeight
        self.barWeight = barWeight
        self.availablePlates = availablePlates
        self.calculatedPlates = calculatedPlates
    }
}



