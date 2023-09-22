//
//  WorkoutEntryView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 02.06.23.
//

import SwiftUI

/// An entry form which allows the user to enter his strength workout data.
/// Uses a binding to add to a given list of workouts in the model.
struct StrengthWorkoutEntryView: View {

    @Binding var isPresented: Bool
    @EnvironmentObject private var viewModel: ViewModel

    // Form Entry state variables
    @State private var date = Date()
    @State private var nameIndex = 0
    @State private var reps = 0
    @State private var sets = 0
    @State private var weight: Double = 0.0

    // MARK: View

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
                    Picker("Name", selection: $nameIndex, content: {
                        ForEach(Array(viewModel.settings.strWorkouts.enumerated()), id: \.element) { (index, item) in
                            Text(item).tag(index)
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
                createDBEntry()
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

    /// Creates a new entry in the persistent DB.
    /// Based on the data model in the Workouts DB
    private func createDBEntry() {
        let dbEntry = StrengthWorkoutEntryDB(context: viewModel.coreDataPersistenceContainer.viewContext)
        dbEntry.id = UUID()
        dbEntry.name = viewModel.settings.strWorkouts[nameIndex]
        dbEntry.timestamp = date
        dbEntry.sets = Int32(sets)
        dbEntry.reps = Int32(reps)
        dbEntry.weight = weight
        dbEntry.recordedWeightUnit = viewModel.settings.weightUnit.rawValue
        try? viewModel.coreDataPersistenceContainer.viewContext.save()
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
