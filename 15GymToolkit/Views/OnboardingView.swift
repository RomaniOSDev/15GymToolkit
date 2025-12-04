//
//  OnboardingView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            OnboardingPageView(
                title: "Welcome to Gym Toolkit",
                description: "Your all-in-one companion for gym workouts. Track your progress, manage rest times, and calculate weights effortlessly.",
                imageName: "figure.strengthtraining.traditional",
                pageIndex: 0,
                hasCompletedOnboarding: $hasCompletedOnboarding
            )
            .tag(0)
            
            OnboardingPageView(
                title: "Rest Timers",
                description: "Never lose track of your rest periods. Use simple, interval, or HIIT timers to optimize your training.",
                imageName: "timer",
                pageIndex: 1,
                hasCompletedOnboarding: $hasCompletedOnboarding
            )
            .tag(1)
            
            OnboardingPageView(
                title: "Barbell Calculator",
                description: "Quickly calculate which plates you need for your target weight. No more guessing or counting!",
                imageName: "scalemass",
                pageIndex: 2,
                hasCompletedOnboarding: $hasCompletedOnboarding
            )
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingPageView: View {
    let title: String
    let description: String
    let imageName: String
    let pageIndex: Int
    @Binding var hasCompletedOnboarding: Bool
    
    init(title: String, description: String, imageName: String, pageIndex: Int, hasCompletedOnboarding: Binding<Bool>) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.pageIndex = pageIndex
        self._hasCompletedOnboarding = hasCompletedOnboarding
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .padding()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            if pageIndex == 2 {
                Button(action: {
                    hasCompletedOnboarding = true
                    UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 50)
            }
        }
    }
}

