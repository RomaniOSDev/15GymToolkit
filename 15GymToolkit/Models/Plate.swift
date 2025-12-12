//
//  Plate.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import Foundation

struct Plate: Identifiable, Codable {
    let id: UUID
    var weight: Double
    var count: Int
    
    init(id: UUID = UUID(), weight: Double, count: Int) {
        self.id = id
        self.weight = weight
        self.count = count
    }
}



