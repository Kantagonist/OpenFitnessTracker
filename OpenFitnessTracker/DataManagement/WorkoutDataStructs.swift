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
    private let weight: Double
    let recordedWeightUnit: WeightUnit

    init(name: String, timestamp: Date, sets: Int, reps: Int, weight: Double, recordedWeightUnit: WeightUnit) {
        self.sets = sets
        self.reps = reps
        self.weight = weight
        self.recordedWeightUnit = recordedWeightUnit
        super.init(name: name, timestamp: timestamp)
    }

    /// Gets the structs distance converted to the given distance unit.
    /// - Parameters:
    ///   - weightUnit: The unit to convert the value into
    /// - Returns: The converted value as a Double
    func getConvertedWeightUnit(for weightUnit: WeightUnit) -> Double {
        if weightUnit == recordedWeightUnit {
            return weight
        }
        switch weightUnit {
        case .kg:
            return weight * 0.45359237
        case .lbs:
            return weight * 2.20462262185
        }
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

    /// Formats the milliseconds duration of this entry into a readable String.
    func getFormattedDurationString() -> String {
        var remainingMS = durationInMilliseconds
        let hourInMilliseconds: UInt64 = 3_600_000
        let minuteInMilliseconds: UInt64 = 60_000
        let secondInMilliseconds: UInt64 = 1_000

        var hours = "00:"
        if remainingMS >= hourInMilliseconds {
            hours = "\(String(remainingMS / hourInMilliseconds)):"
            remainingMS = remainingMS % hourInMilliseconds
        }
        var minutes = "00:"
        if remainingMS >= minuteInMilliseconds {
            minutes = "\(remainingMS / minuteInMilliseconds):"
            remainingMS = remainingMS % minuteInMilliseconds
        }
        var seconds = "00:"
        if remainingMS >= secondInMilliseconds {
            seconds = "\(remainingMS / secondInMilliseconds):"
            remainingMS = remainingMS % secondInMilliseconds
        }
        
        return hours + minutes + seconds + String(format: "%04d", remainingMS)
    }
}
