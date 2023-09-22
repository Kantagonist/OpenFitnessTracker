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
        coreDataPersistenceContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }

    // MARK: Values

    @Published var settings = Settings()

    // MARK: Data Query Handling

    let coreDataPersistenceContainer = NSPersistentContainer(name: "Workouts")
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
