//
//  UnitConversion.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct UnitConversion: Identifiable, Codable {
    let id: UUID
    var fromValue: Double
    var fromUnit: WeightUnit
    var toUnit: WeightUnit
    var convertedValue: Double
    
    init(id: UUID = UUID(), fromValue: Double, fromUnit: WeightUnit, toUnit: WeightUnit, convertedValue: Double) {
        self.id = id
        self.fromValue = fromValue
        self.fromUnit = fromUnit
        self.toUnit = toUnit
        self.convertedValue = convertedValue
    }
}

enum WeightUnit: String, CaseIterable, Codable {
    case kg = "kg"
    case lb = "lb"
    
    func convert(value: Double, to unit: WeightUnit) -> Double {
        if self == unit {
            return value
        }
        
        if self == .kg && unit == .lb {
            return value * 2.20462
        } else if self == .lb && unit == .kg {
            return value / 2.20462
        }
        
        return value
    }
}


