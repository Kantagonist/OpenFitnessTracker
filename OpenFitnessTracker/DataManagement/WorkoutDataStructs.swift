//
//  WorkoutDataStructs.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 24.05.23.
//

import Foundation

/// A data representation of a given workout entry.
/// All objects of this class and its subclasses are uniquely identifiable.
class WorkoutEntry: Identifiable {
    let id = UUID()
    let name: String
    let timestamp: Date

    init(name: String, timestamp: Date) {
        self.name = name
        self.timestamp = timestamp
    }
}

class StrengthWorkoutEntry: WorkoutEntry {
    let sets: Int
    let reps: Int
    let weight: Double

    init(name: String, timestamp: Date, sets: Int, reps: Int, weight: Double) {
        self.sets = sets
        self.reps = reps
        self.weight = weight
        super.init(name: name, timestamp: timestamp)
    }
}

class EnduranceWorkoutEntry: WorkoutEntry {
    let durationInMilliseconds: UInt64
    private let distance: Double
    let recordedDistanceUnit: DistanceUnit

    init(name: String, timestamp: Date, durationInMilliseconds: UInt64, distance: Double, recordedDistanceUnit: DistanceUnit) {
        self.durationInMilliseconds = durationInMilliseconds
        self.distance = distance
        self.recordedDistanceUnit = recordedDistanceUnit
        super.init(name: name, timestamp: timestamp)
    }
    
    /// Gets the structs distance converted to the given distance unit.
    /// - Parameters:
    ///   - distanceUnit: The unit to convert the value into
    /// - Returns: The converted value as a Double
    func getConvertedDistanceUnit(for distanceUnit: DistanceUnit) -> Double {
        if distanceUnit == recordedDistanceUnit {
            return distance
        }
        switch distanceUnit {
        case .km:
            return distance * 1.609344
        case .mile:
            return distance * 0.6213711922
        }
    }
}
