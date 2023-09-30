//
//  ContentView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 05.05.23.
//

import SwiftUI

/// Central scene host which holds the scene container.
struct ContentView: View {

    @StateObject private var model = ViewModel.getInstance()

    var body: some View {
        TabCollection()
            .environmentObject(model)
            .environment(\.managedObjectContext, model.coreDataPersistenceContainer.viewContext) // necessary for DB access.
    }
}

/// Mother view which holds all the existing tabs
struct TabCollection: View {

    /// Data request for the stored app settings
    @FetchRequest(sortDescriptors: []) private var settingsFromDB: FetchedResults<SettingsDB>
    
    @EnvironmentObject private var viewModel: ViewModel

    var body: some View {
        TabView {
            WorkoutInputSceneView()
                .tabItem {
                    Label("Workouts", systemImage: "1.circle")
                }
            StatisticsSceneView()
                .tabItem {
                    Label("Statistics", systemImage: "2.circle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "3.circle")
                }
        }.onAppear {
            if !settingsFromDB.isEmpty {
                viewModel.settings = settingsFromDB[0].getDomainVersion()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
