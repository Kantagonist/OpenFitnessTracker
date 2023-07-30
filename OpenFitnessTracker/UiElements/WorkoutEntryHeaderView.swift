//
//  WorkoutEntryHeaderView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 30.07.23.
//

import SwiftUI

/// A parental view element, which allows the user to display a generic  headline for their workout entry.
struct WorkoutEntryHeaderView: View {

    let entry: WorkoutEntry
    let settings: Settings

    // MARK: View

    var body: some View {
        HStack {
            Text(entry.name)
                .font(.system(size: 24))
                .foregroundColor(settings.headerTextColor)
                .padding()
            Spacer()
            Text(entry.timestamp.formatted(date: .numeric, time: .omitted))
                .font(.system(size: 24))
                .foregroundColor(settings.headerTextColor)
                .padding()
        }
        .padding(16.0)
        .background(settings.headerBackgroundColor)
        .shadow(color: settings.headerBackgroundColor, radius: 10, x: 0, y: 0)
    }
}

// MARK: Preview

fileprivate let demoEntry = WorkoutEntry(
    name: "Deadlift",
    timestamp: .now
)

struct WorkoutEntryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEntryHeaderView(
            entry: demoEntry,
            settings: Settings()
        )
    }
}
