//
//  SettingsView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var showClearDataAlert = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("About")) {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Image(systemName: "doc.text")
                            .foregroundColor(.blue)
                        Button(action: {
                            openPrivacyPolicy()
                        }) {
                            HStack {
                                Text("Privacy Policy")
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Button(action: {
                            rateApp()
                        }) {
                            HStack {
                                Text("Rate Us")
                                Spacer()
                                Image(systemName: "arrow.up.right.square")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .foregroundColor(.primary)
                    }
                }
                
                Section(header: Text("Data")) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.orange)
                        Button(action: {
                            resetOnboarding()
                        }) {
                            Text("Reset Onboarding")
                        }
                        .foregroundColor(.primary)
                    }
                    
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                        Button(action: {
                            showClearDataAlert = true
                        }) {
                            Text("Clear All Data")
                        }
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Clear All Data", isPresented: $showClearDataAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    clearAllData()
                }
            } message: {
                Text("This will delete all your calculation history and conversion history. This action cannot be undone.")
            }
        }
    }
    
    private func openPrivacyPolicy() {
        // Replace with your actual privacy policy URL
        if let url = URL(string: "https://www.example.com/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    private func rateApp() {
        // Try to show in-app review first
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
        
        // Also open App Store page after a delay (optional)
        // Replace with your actual App Store URL when app is published
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        //     if let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") {
        //         UIApplication.shared.open(url)
        //     }
        // }
    }
    
    private func resetOnboarding() {
        hasCompletedOnboarding = false
        UserDefaults.standard.set(false, forKey: "hasCompletedOnboarding")
    }
    
    private func clearAllData() {
        // Clear all stored data
        UserDefaults.standard.removeObject(forKey: "recentCalculations")
        UserDefaults.standard.removeObject(forKey: "conversionHistory")
        UserDefaults.standard.removeObject(forKey: "hasCompletedOnboarding")
        hasCompletedOnboarding = false
    }
}

