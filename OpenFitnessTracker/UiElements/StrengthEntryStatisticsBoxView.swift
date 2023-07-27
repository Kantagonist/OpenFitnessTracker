//
//  StrengthEntryStatisticsBox.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 27.07.23.
//

import SwiftUI

/// A small box which is read-only.
/// It displays information from a given ``StrengthWorkoutEntry``.
struct StrengthEntryStatisticsBoxView: View {
    
    var entry: StrengthWorkoutEntry
    var settings: Settings

    var body: some View {
        Text("You performed the exercise: \(entry.name)\nOn \(entry.timestamp)\nWith \(entry.sets) sets of \(entry.reps) reps while using \(String(format: "%.1f", entry.weight)) \(settings.weightUnit.rawValue)")
    }
}

// MARK: Preview

let demoEntry = StrengthWorkoutEntry(
    name: "Bench",
    timestamp: Date(),
    sets: 3,
    reps: 8,
    weight: 30.0
)

let demoSettings = Settings(
    weightUnit: .kg,
    distanceUnit: .km
)

struct StrengthEntryStatisticsBox_Previews: PreviewProvider {

    static var previews: some View {
        StrengthEntryStatisticsBoxView(
            entry: demoEntry,
            settings: demoSettings
        )
    }
}
