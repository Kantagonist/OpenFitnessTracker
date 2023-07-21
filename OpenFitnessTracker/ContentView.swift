//
//  ContentView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 05.05.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabCollection()
    }
}

/// Mother view which holds all the existing tabs
struct TabCollection: View {

    var body: some View {
        TabView {
            WorkoutInputSceneView()
                .tabItem {
                    Label("Workouts", systemImage: "1.circle")
                }
            PersonalInformationSceneView(person: previewExamplePerson)
                .tabItem {
                    Label("Personal Info", systemImage: "2.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "3.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
