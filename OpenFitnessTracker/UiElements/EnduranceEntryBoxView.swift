//
//  EnduranceEntryBoxView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 28.07.23.
//

import SwiftUI

struct EnduranceEntryBoxView: View {

    let entry: EnduranceWorkoutEntry
    let settings: Settings

    // MARK: View

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
            Text("Time: \(entry.getFormattedDurationString())")
                .font(.system(size: 24))
                .padding()
                .frame(maxWidth: .infinity)
                .border(Color.black)
            Text("Distance \(String(format: "%.2f", entry.getConvertedDistanceUnit(for: settings.distanceUnit))) \(settings.distanceUnit.rawValue)")
                .font(.system(size: 24))
                .padding()
                .frame(maxWidth: .infinity)
                .border(Color.black)
        }
    }
}

// MARK: Preview

private let demoEntry = EnduranceWorkoutEntry(
    name: "Bench Press",
    timestamp: Date(),
    durationInMilliseconds: 100000,
    distance: 10.0,
    recordedDistanceUnit: .km
)

struct EnduranceEntryBoxView_Previews: PreviewProvider {
    static var previews: some View {
        EnduranceEntryBoxView(
            entry: demoEntry,
            settings: Settings()
        )
    }
}
