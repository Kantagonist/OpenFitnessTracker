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
        foto: UIImage(imageLiteralResourceName: "person_icon"),
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
    var foto: UIImage
    var name: String
    var birthdate: Date
}

var strengthWorkoutNames = [
    "Bench Press",
    "Deadlift",
    "Bicep Curl",
    "Overhead Press",
    "Hammercurl",
    "Pull-up"
]

var enduranceWorkoutNames = [
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
