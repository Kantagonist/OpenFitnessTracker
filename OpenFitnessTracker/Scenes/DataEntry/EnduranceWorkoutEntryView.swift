//
//  EnduranceWorkoutEntryView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 28.07.23.
//

import SwiftUI

// MARK: View

/// An entry form which allows the user to enter his endurance workout data.
/// Uses a binding to add to a given list of workouts in the model
struct EnduranceWorkoutEntryView: View {

    @EnvironmentObject private var viewModel: ViewModel

    @Binding var isPresented: Bool

    @State private var date = Date()
    @State private var nameIndex = 0
    private var durationInMilliseconds: UInt64 {
        return UInt64(hours * minutes * seconds * 1_000)
    }
    @State private var distance: Double = 0.0
    @State private var seconds: Int = 0
    @State private var minutes: Int = 0
    @State private var hours: Int = 0

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
                        ForEach(Array(viewModel.settings.endWorkouts.enumerated()), id: \.element) { (index, item) in
                            Text(item).tag(index)
                        }
                    })
                    .foregroundColor(viewModel.settings.textColor)
                    Stepper("Distance: \(String(format: "%.1f", distance)) \(viewModel.settings.distanceUnit.rawValue)", value: $distance, in: 0...Double(Int.max), step: enduranceLengthIncrement)
                    .padding(.top)
                        .padding(.bottom)
                        .foregroundColor(viewModel.settings.textColor)
                    VStack {
                        Text("Time")
                        HStack(alignment: .center, spacing: 0) {
                            Text("H:").fontWeight(.bold)
                            Picker("Hours", selection: $hours) {
                                ForEach(0 ..< 25, id: \.self) { hour in
                                    Text("\(hour)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())

                            Text("M:").fontWeight(.bold)
                            Picker("Minutes", selection: $minutes) {
                                ForEach(0 ..< 61, id: \.self) { minute in
                                    Text("\(minute)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())

                            Text("S:").fontWeight(.bold)
                            Picker("Minutes", selection: $seconds) {
                                ForEach(0 ..< 61, id: \.self) { second in
                                    Text("\(second)")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                    }
                }, header: {
                    Text("Entry")
                })
            }
            .navigationTitle("New Workout Entry")
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
        let dbEntry = EnduranceWorkoutEntryDB(context: viewModel.coreDataPersistenceContainer.viewContext)
        dbEntry.id = UUID()
        dbEntry.name = viewModel.settings.endWorkouts[nameIndex]
        dbEntry.timestamp = date
        dbEntry.durationInMilliseconds = Int64(durationInMilliseconds)
        dbEntry.distance = distance
        dbEntry.recordedDistanceUnit = viewModel.settings.distanceUnit.rawValue
        try! viewModel.coreDataPersistenceContainer.viewContext.save()
    }
}

// MARK: Configs

private let enduranceLengthIncrement: Double = 0.1

// MARK: Preview

struct EnduranceWorkoutEntryView_Previews: PreviewProvider {

    @State private static var show = true

    static var previews: some View {
        EnduranceWorkoutEntryView(
            isPresented: $show
        )
            .environmentObject(ViewModel.getInstance())
    }
}
