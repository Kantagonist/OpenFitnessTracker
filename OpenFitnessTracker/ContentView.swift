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
            PersonalInformationSceneView(person: previewExamplePerson)
                .tabItem {
                    Label("Personal Info", systemImage: "1.circle")
                }
            WorkoutInputSceneView()
                .tabItem {
                    Label("Workouts", systemImage: "2.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
