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
            WorkoutEntryHeaderView(entry: entry, settings: settings)
            HStack {
                Spacer()
                    .frame(width: 10)
                VStack (spacing: 0) {
                    Text("Time: \(entry.getFormattedDurationString())")
                        .font(.system(size: 20))
                        .padding(16.0)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            SelectedBorderShape(
                                sides: [.leading, .trailing, .bottom],
                                cornerRadius: 20.0
                            )
                            .stroke(settings.textColor, lineWidth: 1.0)
                        )
                    Text("Distance \(String(format: "%.2f", entry.getConvertedDistanceUnit(for: settings.distanceUnit))) \(settings.distanceUnit.rawValue)")
                        .font(.system(size: 20))
                        .padding(16.0)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            SelectedBorderShape(
                                sides: [.leading, .trailing, .bottom],
                                cornerRadius: 20.0
                            )
                            .stroke(settings.textColor, lineWidth: 1.0)
                        )
                }
                Spacer()
                    .frame(width: 30)
            }
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
        HStack {
            Spacer()
                .frame(width: 20)
            EnduranceEntryBoxView(
                entry: demoEntry,
                settings: Settings()
            )
            Spacer()
                .frame(width: 20)
        }
    }
}
