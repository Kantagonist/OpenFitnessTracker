//
//  ViewModel.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 24.05.23.
//

import Foundation
import CoreData
import SwiftUI

/// A central point for data handling
class ViewModel: ObservableObject {

    // MARK: Instance Singleton

    private static var instance: ViewModel?

    // Gets singleton instance
    static func getInstance() -> ViewModel {
        if instance == nil {
            instance = ViewModel()
        }
        return instance!
    }

    init() {
        coreDataPersistenceContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    // MARK: Values

    var strengthWorkoutEntries = [StrengthWorkoutEntry]()
    var enduranceWorkoutEntries = [EnduranceWorkoutEntry]()
    @Published var settings = Settings()

    // MARK: Data Query Handling

    let coreDataPersistenceContainer = NSPersistentContainer(name: "Workouts")

    // MARK: Misc Data Getters

    /// Gets the highest possible distance for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    func getHighestEnduranceDistance(for name: String) -> Double {
        var result: Double = 0
        for entry in enduranceWorkoutEntries {
            let distance = entry.getConvertedDistanceUnit(for: settings.distanceUnit)
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Gets the highest possible weight for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    func getHighestStrengthWeight(for name: String) -> Double {
        var result: Double = 0
        for entry in strengthWorkoutEntries {
            let distance = entry.getConvertedWeightUnit(for: settings.weightUnit)
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Sorts all entries by date and returns in ascending order.
    /// - Returns: A list of workouts in ascending order
    func allWorkoutsSortedByDate() -> [WorkoutEntry] {
        var result = [WorkoutEntry]()
        result.append(contentsOf: strengthWorkoutEntries)
        result.append(contentsOf: enduranceWorkoutEntries)

        return result.sorted(by: {
            $0.timestamp.compare($1.timestamp) == .orderedAscending
        })
    }
}

// MARK: DB Extensions

extension StrengthWorkoutEntryDB {
    private func getWeightUnit() -> WeightUnit {
        if recordedWeightUnit == "kg" {
            return .kg
        } else {
            return .lbs
        }
    }
    func convertToDomainVersion() -> StrengthWorkoutEntry {
        return StrengthWorkoutEntry(
            id: id!,
            name: name!,
            timestamp: timestamp!,
            sets: Int(sets),
            reps: Int(sets),
            weight: weight,
            recordedWeightUnit: getWeightUnit()
        )
    }
}

extension EnduranceWorkoutEntryDB {
    private func getDistanceUnit() -> DistanceUnit {
        if recordedDistanceUnit == "km" {
            return .km
        } else {
            return .mile
        }
    }
    func convertToDomainVersion() -> EnduranceWorkoutEntry {
        return EnduranceWorkoutEntry(
            id: id!,
            name: name!,
            timestamp: timestamp!,
            durationInMilliseconds: UInt64(durationInMilliseconds),
            distance: distance,
            recordedDistanceUnit: getDistanceUnit()
        )
    }
}
