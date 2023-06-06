//
//  WorkoutDataStructs.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 24.05.23.
//

import Foundation

/// A data representation of a given workout statistic
class WorkoutEntry {
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
    let durationInMilliseconds: Int64
    let lengthInCentimeters: Int64
    init(name: String, timestamp: Date, durationInMilliseconds: Int64, lengthInCentimeters: Int64) {
        self.durationInMilliseconds = durationInMilliseconds
        self.lengthInCentimeters = lengthInCentimeters
        super.init(name: name, timestamp: timestamp)
    }
}
