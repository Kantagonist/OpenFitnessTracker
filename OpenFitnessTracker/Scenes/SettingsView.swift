//
//  SettingsView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 18.07.23.
//

import SwiftUI

/// new settings page, which allows for
struct SettingsView: View {

    @State private var viewModel = ViewModel.getInstance()

    // MARK: Main View

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("General")) {
                    Picker("Weight Unit", selection: $viewModel.settings.weightUnit, content: {
                        ForEach(WeightUnit.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    })
                    Picker("Distance Unit", selection: $viewModel.settings.distanceUnit, content: {
                        ForEach(DistanceUnit.allCases, id: \.self) { unit in
                            Text("\(unit.rawValue)")
                        }
                    })
                }
            }
            // TODO: create add workout system
            .navigationBarTitle("Settings")
        }
    }
}

// MARK: Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

// MARK: Data Structs

/// Struct which holds the current settings.
struct Settings {
    var weightUnit: WeightUnit = .kg
    var distanceUnit: DistanceUnit = .km
    let strWorkouts = strengthWorkoutNames
    let endWorkouts = enduranceWorkoutNames
}

var strengthWorkoutNames = [
    "Bench Press",
    "Deadlift",
    "Bicep Curl",
    "Overhead Press",
    "Hammercurl",
    "Pull-up"
]

var enduranceWorkoutNames = [
    "Jogging",
    "Cycling",
    "Swimming"
]

enum WeightUnit: String, CaseIterable {
    case kg
    case lbs
}

enum DistanceUnit: String, CaseIterable {
    case km
    case mile
}
