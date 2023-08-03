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
        ZStack {
            VStack {
                Spacer()
                    .frame(width: 20)
                HStack {
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
                    .padding(10.0)
                    .background(settings.headerBackgroundColor)
                    .shadow(color: settings.headerBackgroundColor, radius: 10, x: 0, y: 0)
                    Spacer()
                        .frame(width: 20)
                }
            }
            .frame(maxHeight: 100)
            VStack {
                HStack {
                    Spacer()
                        .frame(width: .infinity)
                    Button("X", action: {
                        
                    })
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                }
                Spacer()
            }
            .frame(maxHeight: 100)
        }
    }
}

// MARK: Preview

fileprivate let demoEntry = WorkoutEntry(
    name: "Deadlift",
    timestamp: .now
)

struct WorkoutEntryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer().frame(width: 20)
            WorkoutEntryHeaderView(
                entry: demoEntry,
                settings: Settings()
            )
            Spacer()
                .frame(width: 20)
        }
    }
}
