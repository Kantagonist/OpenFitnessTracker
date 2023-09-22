//
//  StatisticsSceneView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 23.05.23.
//

import SwiftUI

/// Page which displays certain user statistics pulled form existing workouts
struct StatisticsSceneView: View {

    // MARK: Data requests

    /// Data request for all strength workouts inside the DB, ordered by oldest date.
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(key: "timestamp", ascending: true)
    ]) private var strengthWorkouts: FetchedResults<StrengthWorkoutEntryDB>
    
    /// Data request for all endurance workouts inside the DB, ordered by oldest date.
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(key: "timestamp", ascending: true)
    ]) private var enduranceWorkouts: FetchedResults<EnduranceWorkoutEntryDB>

    
    // MARK: State bjects

    @EnvironmentObject private var viewModel: ViewModel

    @State private var presentPopover = false

    // MARK: View

    var body: some View {

        NavigationView {
            List {
                Section(header: Text("Max Values")) {
                    VStack(spacing: 5) {
                        ForEach(viewModel.settings.endWorkouts, id: \.self) { workout in
                            HStack {
                                Text(workout)
                                Spacer()
                                Text("\(String(format: "%.4f", getHighestEnduranceDistance(for: workout))) \(viewModel.settings.distanceUnit.rawValue)")
                            }
                        }
                    }
                    VStack(spacing: 5) {
                        ForEach(viewModel.settings.strWorkouts, id: \.self) { workout in
                            HStack {
                                Text(workout)
                                Spacer()
                                Text("\(String(format: "%.2f", getHighestStrengthWeight(for: workout))) \(viewModel.settings.weightUnit.rawValue)")
                            }
                        }
                    }
                }

                Section(header: Text("Frequency")) {
                    FrequencyStatisticView(workouts: getAllWorkoutsSortedByDate())
                }

                Section(header: Text("Details")) {
                    ForEach(viewModel.settings.endWorkouts, id: \.self) { workout in
                        Button(workout) {
                            presentPopover = true
                        }.popover(isPresented: $presentPopover) {
                            DetailEnduranceStatisticsView(
                                name: workout,
                                distanceUnit: viewModel.settings.distanceUnit,
                                workouts: getEnduranceWorkouts(with: workout)
                            )
                        }
                    }
                    .foregroundColor(.blue)
                    ForEach(viewModel.settings.strWorkouts, id: \.self) { workout in
                        Button(workout) {
                            presentPopover = true
                        }.popover(isPresented: $presentPopover) {
                            DetailStrengthStatisticsView(
                                name: workout,
                                weightUnit: viewModel.settings.weightUnit,
                                workouts: getStrengthWorkouts(with: workout)
                            )
                        }
                    }
                    .foregroundColor(.blue)
                }
            }
            .foregroundColor(viewModel.settings.textColor)
            .navigationBarTitle("Statistics")
        }
    }

    // MARK: Misc Data Getters

    /// Gets the highest possible weight for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    func getHighestStrengthWeight(for name: String) -> Double {
        var result: Double = 0
        for entry in strengthWorkouts {
            let distance = entry.convertToDomainVersion().getConvertedWeightUnit(
                for: viewModel.settings.weightUnit
            )
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Gets the highest possible distance for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    private func getHighestEnduranceDistance(for name: String) -> Double {
        var result: Double = 0
        for entry in enduranceWorkouts {
            let distance = entry.convertToDomainVersion().getConvertedDistanceUnit(
                for: viewModel.settings.distanceUnit
            )
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Sorts all entries by date and returns in ascending order.
    /// - Returns: A list of workouts in ascending order in domain version
    func getAllWorkoutsSortedByDate() -> [WorkoutEntry] {
        var result = [WorkoutEntry]()
        enduranceWorkouts.forEach { workout in
            result.append(workout.convertToDomainVersion())
        }
        strengthWorkouts.forEach { workout in
            result.append(workout.convertToDomainVersion())
        }
        return result
    }

    /// Creates a list of strength workouts with the given name in ascending date order.
    ///  - Returns: The workout list in domain form.
    func getStrengthWorkouts(with name: String) -> [StrengthWorkoutEntry] {
        var result = [StrengthWorkoutEntry]()
        strengthWorkouts.forEach { workout in
            if name == workout.name {
                result.append(workout.convertToDomainVersion())
            }
        }
        return result
    }

    /// Creates a list of endurance workouts with the given name in ascending date order.
    ///  - Returns: The workout list in domain form.
    func getEnduranceWorkouts(with name: String) -> [EnduranceWorkoutEntry] {
        var result = [EnduranceWorkoutEntry]()
        enduranceWorkouts.forEach { workout in
            if name == workout.name {
                result.append(workout.convertToDomainVersion())
            }
        }
        return result
    }
}

// MARK: Preview

struct PersonalInformationSceneView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSceneView()
            .environmentObject(ViewModel.getInstance())
    }
}
