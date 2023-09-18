//
//  WorkoutEntryView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 02.06.23.
//

import SwiftUI

// MARK: View

/// An entry form which allows the user to enter his strength workout data.
/// Uses a binding to add to a given list of workouts in the model.
struct StrengthWorkoutEntryView: View {

    @Binding var isPresented: Bool
    @EnvironmentObject private var viewModel: ViewModel

    // Form Entry state variables
    @State private var date = Date()
    @State private var name = ""
    @State private var reps = 0
    @State private var sets = 0
    @State private var weight: Double = 0.0

    var body: some View {
        VStack {
            Form {
                Section(content: {
                    DatePicker("Date:", selection: $date, displayedComponents: .date)
                        .foregroundColor(viewModel.settings.textColor)
                }, header: {
                    Text("Date")
                })
                Section(content: {
                    Picker("Name", selection: $name, content: {
                        ForEach(0 ..< viewModel.settings.strWorkouts.count, id: \.self) { name in
                            Text(viewModel.settings.strWorkouts[name])
                        }
                    })
                    .foregroundColor(viewModel.settings.textColor)
                    Stepper("Sets: \(sets)", value: $sets, in: 0...Int.max, step: 1)
                        .padding(.top)
                        .padding(.bottom)
                        .foregroundColor(viewModel.settings.textColor)
                    Stepper("Reps: \(reps)", value: $reps, in: 0...Int.max, step: 1)
                        .padding(.top)
                        .padding(.bottom)
                        .foregroundColor(viewModel.settings.textColor)
                    Stepper("Weight: \(String(format: "%.1f", weight)) \(viewModel.settings.weightUnit.rawValue)", value: $weight, in: 0...Double(Int.max), step: 2.5)
                    .padding(.top)
                    .padding(.bottom)
                    .foregroundColor(viewModel.settings.textColor)
                }, header: {
                    Text("Entry")
                })
            }.navigationTitle("New Workout Entry")
                .fixedSize(horizontal: false, vertical: false)
            Button(action: {
                createStrengthEntry()
                isPresented = false
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
            })
            .frame(width: 200.0, height: 50.0)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(16.0)
                .padding(.bottom, 16.0)
        }
    }

    private func createStrengthEntry() {
        let domainEntry = StrengthWorkoutEntry(
            name: name,
            timestamp: date,
            sets: sets,
            reps: reps,
            weight: weight,
            recordedWeightUnit: viewModel.settings.weightUnit
        )
        /*
        viewModel.strengthWorkoutEntries.append(
            domainEntry
        )
         */
        let dbEntry = StrengthWorkoutEntryDB(context: viewModel.coreDataPersistenceContainer.viewContext)
        dbEntry.id = domainEntry.id
        dbEntry.name = domainEntry.name
        dbEntry.timestamp = domainEntry.timestamp
        dbEntry.sets = Int32(domainEntry.sets)
        dbEntry.reps = Int32(domainEntry.reps)
        dbEntry.weight = domainEntry.getConvertedWeightUnit(for: domainEntry.recordedWeightUnit)
        dbEntry.recordedWeightUnit = domainEntry.recordedWeightUnit.rawValue
        try! viewModel.coreDataPersistenceContainer.viewContext.save()
        
        // TODO: Save doesnt' work
        // find way to make safe work and replace usage of viewModel values.
        // Instead they should just function as domain conversions for the DB generated values.
    }
}

// MARK: Configs

private let weightIncrement: Double = 2.5

// MARK: Preview

struct WorkoutEntryView_Previews: PreviewProvider {
    @State private static var entries = [StrengthWorkoutEntry]()
    @State private static var show = true
    private static let settings = Settings()

    static var previews: some View {
        StrengthWorkoutEntryView(
            isPresented: $show
        )
            .environmentObject(ViewModel.getInstance())
    }
}
