//
//  ContentView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}

#Preview {
    ContentView()
}
