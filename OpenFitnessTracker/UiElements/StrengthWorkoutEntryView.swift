//
//  WorkoutEntryView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 02.06.23.
//

import SwiftUI

// MARK: View

/// An entry form which allows the user to enter his workout data.
/// Uses a binding to add to a given list of workouts.
struct StrengthWorkoutEntryView: View {

    // References the existing central list of workout entries.
    // This binding is used to manipulate the original source of truth.
    @Binding var existingEntries: [StrengthWorkoutEntry]
    @Binding var isPresented: Bool

    // Form Entry state variables
    @State private var date = Date()
    @State private var name = strengthWorkoutNames[0]
    @State private var reps = 0
    @State private var sets = 0
    @State private var weight: Double = 0.0

    var body: some View {
        VStack {
            Form {
                Section(content: {
                    DatePicker("Date:", selection: $date, displayedComponents: .date)
                        .foregroundColor(textColor)
                }, header: {
                    Text("Date")
                })
                Section(content: {
                    Picker("Name", selection: $name, content: {
                        ForEach(0 ..< strengthWorkoutNames.count, id: \.self) { name in
                            Text(strengthWorkoutNames[name])
                        }
                    })
                    .foregroundColor(textColor)
                    Stepper("Sets: \(sets)", value: $sets, in: 0...Int.max, step: 1)
                        .padding(.top)
                        .padding(.bottom)
                        .foregroundColor(textColor)
                    Stepper("Reps: \(reps)", value: $reps, in: 0...Int.max, step: 1)
                        .padding(.top)
                        .padding(.bottom)
                        .foregroundColor(textColor)
                    Stepper("Weight: \(String(format: "%.1f", weight)) kg", value: $weight, in: 0...Double(Int.max), step: 2.5)
                    .padding(.top)
                    .padding(.bottom)
                    .foregroundColor(textColor)
                }, header: {
                    Text("Entry")
                })
            }.navigationTitle("New Workout Entry")
                .fixedSize(horizontal: false, vertical: false)
            Button(action: {
                existingEntries.append(
                    StrengthWorkoutEntry(
                        name: name,
                        timestamp: date,
                        sets: sets,
                        reps: reps,
                        weight: weight
                    )
                )
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
}

// MARK: Configs

private let textColor: Color = .black
private let weightIncrement: Double = 2.5

// MARK: Preview
struct WorkoutEntryView_Previews: PreviewProvider {
    @State private static var entries = [StrengthWorkoutEntry]()
    @State private static var show = true

    static var previews: some View {
        StrengthWorkoutEntryView(existingEntries: $entries, isPresented: $show)
    }
}
