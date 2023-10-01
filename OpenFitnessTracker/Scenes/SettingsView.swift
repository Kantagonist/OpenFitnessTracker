//
//  SettingsView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 18.07.23.
//

import SwiftUI
import CoreData

/// new settings page, which allows for
struct SettingsView: View {

    /// Data request for the stored app settings, used for deletion
    @FetchRequest(sortDescriptors: []) private var settingsFromDB: FetchedResults<SettingsDB>

    @EnvironmentObject private var viewModel: ViewModel

    @State private var presentPopOver = false
    @State private var name = ""
    @State private var presentNameChangeDialog = false

    // MARK: Main View

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Profile")) {
                    Label(name, image: viewModel.settings.person.fotoName)
                        .onTapGesture {
                            presentNameChangeDialog = true
                        }
                        .alert("Enter your Name", isPresented: $presentNameChangeDialog) {
                            TextField("", text: $name)
                                .autocorrectionDisabled(true)
                        }
                    DatePicker("Birthdate", selection: $viewModel.settings.person.birthdate, displayedComponents: .date)
                }

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
                }

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
                Button("Save Settings") {
                    // delete old settings
                    for settings in settingsFromDB {
                        viewModel.coreDataPersistenceContainer.viewContext.delete(settings)
                    }
                    // create new entry
                    let dbSettings = SettingsDB(context: viewModel.coreDataPersistenceContainer.viewContext)
                    dbSettings.birthdate = viewModel.settings.person.birthdate
                    dbSettings.distanceUnit = viewModel.settings.distanceUnit.rawValue
                    dbSettings.enduranceWorkouts = viewModel.settings.endWorkouts as NSObject
                    dbSettings.fotoName = viewModel.settings.person.fotoName
                    dbSettings.name = viewModel.settings.person.name
                    dbSettings.strengthWorkouts = viewModel.settings.strWorkouts as NSObject
                    dbSettings.weightUnit = viewModel.settings.weightUnit.rawValue
                    try? viewModel.coreDataPersistenceContainer.viewContext.save()
                }.foregroundColor(.blue)

            }
            .foregroundColor(viewModel.settings.textColor)
            .navigationBarTitle("Settings")
        }
        .onAppear {
            name = viewModel.settings.person.name
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
