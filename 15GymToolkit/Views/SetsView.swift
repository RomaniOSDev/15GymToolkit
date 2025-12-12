//
//  SetsView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct SetsView: View {
    @StateObject private var viewModel = WorkoutViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                if let exercise = viewModel.currentExercise {
                    // Exercise Display
                    VStack(spacing: 20) {
                        Text(exercise.exerciseName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(exercise.completedSets) / \(exercise.targetSets) sets")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        
                        // Progress Bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 20)
                                    .cornerRadius(10)
                                
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(width: geometry.size.width * CGFloat(viewModel.getProgress()), height: 20)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(height: 20)
                        .padding(.horizontal, 40)
                        
                        if let weight = exercise.weight, weight > 0 {
                            Text("Weight: \(String(format: "%.1f", weight)) kg")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        
                        Text("\(exercise.repsPerSet) reps per set")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Add Set Button
                    Button(action: {
                        viewModel.addSet()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                            Text("Add Set")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(exercise.completedSets >= exercise.targetSets ? Color.gray : Color.green)
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                    }
                    .disabled(exercise.completedSets >= exercise.targetSets)
                    
                    // Reset Button
                    Button(action: {
                        viewModel.resetExercise()
                    }) {
                        Text("New Exercise")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 40)
                } else {
                    // Exercise Setup Form
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Exercise Name")
                                .font(.headline)
                            TextField("e.g., Bench Press", text: $viewModel.exerciseName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Target Sets")
                                    .font(.headline)
                                TextField("3", text: $viewModel.targetSets)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Reps per Set")
                                    .font(.headline)
                                TextField("10", text: $viewModel.repsPerSet)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.numberPad)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Weight (kg) - Optional")
                                .font(.headline)
                            TextField("0", text: $viewModel.weight)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                        }
                        
                        Button(action: {
                            viewModel.createExercise()
                        }) {
                            Text("Start Exercise")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .padding(.top)
            .navigationTitle("Exercise Sets")
        }
    }
}



