//
//  BarbellView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct BarbellView: View {
    @StateObject private var viewModel = BarbellViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Input Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Target Weight (kg)")
                            .font(.headline)
                        
                        TextField("Enter weight", text: $viewModel.targetWeight)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
                        Text("Bar Weight")
                            .font(.headline)
                            .padding(.top)
                        
                        Picker("Bar Weight", selection: $viewModel.barWeight) {
                            Text("20 kg").tag(20.0)
                            Text("15 kg").tag(15.0)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Button(action: {
                            viewModel.calculatePlates()
                        }) {
                            Text("Calculate")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Results Section
                    if !viewModel.calculatedPlates.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Required Plates")
                                .font(.headline)
                            
                            Text("Total: \(String(format: "%.1f", viewModel.getTotalWeight())) kg")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            // Visual Barbell
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 5) {
                                    // Left plates
                                    HStack(spacing: 5) {
                                        ForEach(viewModel.calculatedPlates.reversed()) { plate in
                                            ForEach(0..<plate.count, id: \.self) { _ in
                                                PlateView(weight: plate.weight)
                                            }
                                        }
                                    }
                                    
                                    // Bar
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(width: 100, height: 20)
                                        .overlay(
                                            Text("\(String(format: "%.0f", viewModel.barWeight))kg")
                                                .font(.caption)
                                                .foregroundColor(.white)
                                        )
                                    
                                    // Right plates
                                    HStack(spacing: 5) {
                                        ForEach(viewModel.calculatedPlates) { plate in
                                            ForEach(0..<plate.count, id: \.self) { _ in
                                                PlateView(weight: plate.weight)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                            
                            // Plate List
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(viewModel.calculatedPlates) { plate in
                                    HStack {
                                        Text("\(String(format: "%.1f", plate.weight)) kg")
                                        Spacer()
                                        Text("× \(plate.count)")
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Recent Calculations
                    if !viewModel.recentCalculations.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Recent Calculations")
                                .font(.headline)
                            
                            ForEach(viewModel.recentCalculations.prefix(5)) { calculation in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(String(format: "%.1f", calculation.targetWeight)) kg")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                        Text("Bar: \(String(format: "%.0f", calculation.barWeight)) kg")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text("\(String(format: "%.1f", (calculation.calculatedPlates?.reduce(0) { $0 + ($1.weight * Double($1.count) * 2) } ?? 0) + calculation.barWeight)) kg")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Barbell Calculator")
        }
    }
}

struct PlateView: View {
    let weight: Double
    
    var color: Color {
        switch weight {
        case 25: return .red
        case 20: return .blue
        case 15: return .yellow
        case 10: return .green
        case 5: return .white
        case 2.5: return .orange
        case 1.25: return .purple
        default: return .gray
        }
    }
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 35, height: 35)
            .overlay(
                Text("\(String(format: "%.0f", weight))")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(weight == 5 ? .black : .white)
            )
    }
}

