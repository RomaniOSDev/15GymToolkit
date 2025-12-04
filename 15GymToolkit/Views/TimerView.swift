//
//  TimerView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerViewModel()
    
    let presets: [TimeInterval] = [30, 60, 90, 120]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Timer Type Picker
                Picker("Timer Type", selection: $viewModel.selectedType) {
                    ForEach(TimerType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .onChange(of: viewModel.selectedType) { newValue in
                    viewModel.setTimerType(newValue)
                }
                
                Spacer()
                
                // Timer Display
                VStack(spacing: 20) {
                    Text(viewModel.formatTime(viewModel.timeRemaining))
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .monospacedDigit()
                        .foregroundColor(viewModel.timeRemaining <= 10 && viewModel.isRunning ? .red : .primary)
                    
                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                                .cornerRadius(4)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: geometry.size.width * CGFloat(viewModel.timeRemaining / (viewModel.timer?.duration ?? 1)), height: 8)
                                .cornerRadius(4)
                        }
                    }
                    .frame(height: 8)
                    .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Preset Buttons
                HStack(spacing: 15) {
                    ForEach(presets, id: \.self) { preset in
                        Button(action: {
                            viewModel.setDuration(preset)
                        }) {
                            Text("\(Int(preset))s")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 50)
                                .background(Color.blue.opacity(0.7))
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // Control Buttons
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.resetTimer()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        if viewModel.isRunning {
                            viewModel.pauseTimer()
                        } else {
                            viewModel.startTimer()
                        }
                    }) {
                        Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 40)
            }
            .navigationTitle("Rest Timer")
        }
    }
}


