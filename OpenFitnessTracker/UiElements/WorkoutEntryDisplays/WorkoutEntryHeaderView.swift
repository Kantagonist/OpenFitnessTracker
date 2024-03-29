//
//  WorkoutEntryHeaderView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 30.07.23.
//

import SwiftUI

/// A parental view element, which allows the user to display a generic  headline for their workout entry.
struct WorkoutEntryHeaderView: View {

    /// Data request for all strength workouts inside the DB, ordered by newest date.
    @FetchRequest(sortDescriptors: []) private var strengthWorkouts: FetchedResults<StrengthWorkoutEntryDB>

    /// Data request for all endurance workouts inside the DB, ordered by newest date.
    @FetchRequest(sortDescriptors: []) private var enduranceWorkouts: FetchedResults<EnduranceWorkoutEntryDB>

    /// Informal access to the viewModel state.
    /// Allows the user to change the state of views which are higher up in the hierarchy.
    @EnvironmentObject private var viewModel: ViewModel

    let entry: WorkoutEntry

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
                            .foregroundColor(viewModel.settings.headerTextColor)
                            .padding()
                        Spacer()
                        Text(entry.timestamp.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 24))
                            .foregroundColor(viewModel.settings.headerTextColor)
                            .padding()
                    }
                    .padding(10.0)
                    .background(viewModel.settings.headerBackgroundColor)
                    .shadow(
                        color: viewModel.settings.headerBackgroundColor,
                        radius: 10,
                        x: 0,
                        y: 0
                    )
                    Spacer()
                        .frame(width: 20)
                }
            }
            .frame(maxHeight: 100)
            VStack {
                HStack {
                    Spacer()
                    Button("X", action: {
                        deleteEntryFromDB(with: entry.id)
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

    /// Deletes the given entry from the DB.
    /// - Parameter id: The UUID of the entry to delete
    private func deleteEntryFromDB(with id: UUID) {
        for entry in strengthWorkouts where entry.id == id {
            viewModel.coreDataPersistenceContainer.viewContext.delete(entry)
            try? viewModel.coreDataPersistenceContainer.viewContext.save()
            return
        }
        for entry in enduranceWorkouts where entry.id == id {
            viewModel.coreDataPersistenceContainer.viewContext.delete(entry)
            try? viewModel.coreDataPersistenceContainer.viewContext.save()
            return
        }
    }
}

// MARK: Preview

private let demoEntry = WorkoutEntry(
    name: "Deadlift",
    timestamp: .now
)

struct WorkoutEntryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer().frame(width: 20)
            WorkoutEntryHeaderView(
                entry: demoEntry
            )
                .environmentObject(ViewModel.getInstance())
            Spacer()
                .frame(width: 20)
        }
    }
}
