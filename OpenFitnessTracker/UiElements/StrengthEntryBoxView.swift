//
//  StrengthEntryStatisticsBox.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 27.07.23.
//

import SwiftUI

/// A small box which is read-only.
/// It displays information from a given ``StrengthWorkoutEntry``.
struct StrengthEntryBoxView: View {
    
    let entry: StrengthWorkoutEntry
    let settings: Settings

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("\(entry.name)")
                    .font(.system(size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color.black)
                Text(entry.timestamp.formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color.black)
            }
            HStack(spacing: 0) {
                Text("Sets: \(entry.sets)")
                    .font(.system(size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color.black)
                Text("Reps: \(entry.reps)")
                    .font(.system(size: 16))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color.black)
            }
            Text("\(String(format: "%.2f", entry.getConvertedDistanceUnit(for: settings.weightUnit))) \(settings.weightUnit.rawValue)")
                .font(.system(size: 24))
                .padding()
                .frame(maxWidth: .infinity)
                .border(Color.black)
        }
    }
}

// MARK: Preview

private let demoEntry = StrengthWorkoutEntry(
    name: "Bench Press",
    timestamp: Date(),
    sets: 3,
    reps: 8,
    weight: 30.0,
    recordedWeightUnit: .kg
)

private let demoSettings = Settings(
    weightUnit: .kg,
    distanceUnit: .km
)

struct StrengthEntryStatisticsBox_Previews: PreviewProvider {

    static var previews: some View {
        StrengthEntryBoxView(
            entry: demoEntry,
            settings: demoSettings
        )
    }
}
