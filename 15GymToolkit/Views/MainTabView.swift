//
//  MainTabView.swift
//  15GymToolkit
//
//  Created by Роман Главацкий on 25.11.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            
            BarbellView()
                .tabItem {
                    Label("Barbell", systemImage: "scalemass")
                }
            
            SetsView()
                .tabItem {
                    Label("Sets", systemImage: "list.bullet.rectangle")
                }
            
            ConverterView()
                .tabItem {
                    Label("Converter", systemImage: "arrow.left.arrow.right")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

