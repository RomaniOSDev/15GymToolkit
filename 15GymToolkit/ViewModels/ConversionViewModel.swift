//
//  ConversionViewModel.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation
import Combine

class ConversionViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var fromUnit: WeightUnit = .kg
    @Published var toUnit: WeightUnit = .lb
    @Published var convertedValue: Double = 0
    @Published var conversionHistory: [UnitConversion] = []
    
    init() {
        loadHistory()
    }
    
    func convert() {
        guard let value = Double(inputValue) else {
            convertedValue = 0
            return
        }
        
        convertedValue = fromUnit.convert(value: value, to: toUnit)
        
        let conversion = UnitConversion(
            fromValue: value,
            fromUnit: fromUnit,
            toUnit: toUnit,
            convertedValue: convertedValue
        )
        
        conversionHistory.insert(conversion, at: 0)
        if conversionHistory.count > 20 {
            conversionHistory.removeLast()
        }
        
        saveHistory()
    }
    
    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(conversionHistory) {
            UserDefaults.standard.set(encoded, forKey: "conversionHistory")
        }
    }
    
    private func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: "conversionHistory"),
           let decoded = try? JSONDecoder().decode([UnitConversion].self, from: data) {
            conversionHistory = decoded
        }
    }
}



