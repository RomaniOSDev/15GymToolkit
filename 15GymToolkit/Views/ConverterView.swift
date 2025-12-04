//
//  ConverterView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct ConverterView: View {
    @StateObject private var viewModel = ConversionViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    // Conversion Input
                    VStack(spacing: 20) {
                        Text("Enter Value")
                            .font(.headline)
                        
                        TextField("0", text: $viewModel.inputValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .onChange(of: viewModel.inputValue) { _ in
                                viewModel.convert()
                            }
                        
                        HStack(spacing: 30) {
                            VStack {
                                Text("From")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Picker("From Unit", selection: $viewModel.fromUnit) {
                                    ForEach(WeightUnit.allCases, id: \.self) { unit in
                                        Text(unit.rawValue).tag(unit)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .onChange(of: viewModel.fromUnit) { _ in
                                    viewModel.convert()
                                }
                            }
                            
                            Image(systemName: "arrow.left.arrow.right")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            VStack {
                                Text("To")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Picker("To Unit", selection: $viewModel.toUnit) {
                                    ForEach(WeightUnit.allCases, id: \.self) { unit in
                                        Text(unit.rawValue).tag(unit)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .onChange(of: viewModel.toUnit) { _ in
                                    viewModel.convert()
                                }
                            }
                        }
                        
                        // Result Display
                        if !viewModel.inputValue.isEmpty {
                            VStack(spacing: 10) {
                                Text("Result")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                Text(String(format: "%.2f", viewModel.convertedValue))
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundColor(.blue)
                                
                                Text(viewModel.toUnit.rawValue)
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Conversion History
                    if !viewModel.conversionHistory.isEmpty {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Recent Conversions")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(viewModel.conversionHistory.prefix(10)) { conversion in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(String(format: "%.2f", conversion.fromValue))
                                            .font(.headline)
                                        Text(conversion.fromUnit.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.right")
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        Text(String(format: "%.2f", conversion.convertedValue))
                                            .font(.headline)
                                            .foregroundColor(.blue)
                                        Text(conversion.toUnit.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Unit Converter")
        }
    }
}


