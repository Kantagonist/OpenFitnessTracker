//
//  SettingsView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 18.07.23.
//

import SwiftUI

/// new settings page, which allows for
struct SettingsView: View {

    @EnvironmentObject private var viewModel: ViewModel
    @State private var presentPopOver = false

    // MARK: Main View

    var body: some View {
        NavigationView {
            List {

                Section(header: Text("Profile")) {
                    Label("\(viewModel.settings.person.name)", image: viewModel.settings.person.fotoName)
                    DatePicker("Birthdate", selection: $viewModel.settings.person.birthdate, displayedComponents: .date)
                }.foregroundColor(viewModel.settings.textColor)

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
                    ColorPicker("Text color", selection: $viewModel.settings.textColor)
                }.foregroundColor(viewModel.settings.textColor)

                Section(header: Text("Workouts")) {
                    Button("Change Workouts") {
                        presentPopOver = true
                    }.popover(isPresented: $presentPopOver, content: {
                        VStack(spacing: 5) {
                            WorkoutListPicker(entries: $viewModel.settings.endWorkouts)
                            WorkoutListPicker(entries: $viewModel.settings.strWorkouts)
                        }
                    })
                }

            }
            .navigationBarTitle("Settings")
        }
    }
}

// MARK: Preview

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewModel.getInstance())
    }
}
