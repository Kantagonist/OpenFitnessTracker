//
//  SettingsDataStructs.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 28.07.23.
//

import Foundation
import SwiftUI

/// Struct which holds the current settings.
struct Settings {
    var person = Person(
        fotoName: "person_icon",
        name: "Placeholder Name",
        birthdate: .now
    )
    var weightUnit: WeightUnit = .kg
    var distanceUnit: DistanceUnit = .km
    var strWorkouts = strengthWorkoutNames
    var endWorkouts = enduranceWorkoutNames
    var textColor = Color("TextColor")
    let headerTextColor = Color("HeaderText")
    let headerBackgroundColor = Color("HeaderBackground")
}

/// Data representation of app user
struct Person {
    var fotoName: String
    var name: String
    var birthdate: Date
}

private var strengthWorkoutNames = [
    "Bench Press",
    "Deadlift",
    "Bicep Curl",
    "Overhead Press",
    "Hammercurl",
    "Pull-up"
]

private var enduranceWorkoutNames = [
    "Jogging",
    "Cycling",
    "Swimming"
]

enum WeightUnit: String, CaseIterable {
    case kg
    case lbs
}

enum DistanceUnit: String, CaseIterable {
    case km
    case mile
}
