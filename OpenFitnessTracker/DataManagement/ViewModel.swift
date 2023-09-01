//
//  ViewModel.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 24.05.23.
//

import Foundation

/// A central point for data handling
class ViewModel: ObservableObject {

    // MARK: Instance Singleton

    private static var instance: ViewModel?

    // Gets singleton instance
    static func getInstance() -> ViewModel {
        if instance == nil {
            instance = ViewModel()
        }
        return instance!
    }

    func deleteFromModel(_ deletionUUID: UUID?) {
        if let id = deletionUUID {
            var strengthIterator = strengthWorkoutEntries.makeIterator()
            var i = 0
            while let entry = strengthIterator.next() {
                if entry.id == id {
                    strengthWorkoutEntries.remove(at: i)
                    break
                }
                i += 1
            }
            var enduranceIterator = enduranceWorkoutEntries.makeIterator()
            i = 0
            while let entry = enduranceIterator.next() {
                if entry.id == id {
                    enduranceWorkoutEntries.remove(at: i)
                    break
                }
                i += 0
            }
        }
    }

    // MARK: Values

    @Published var strengthWorkoutEntries = [StrengthWorkoutEntry]()
    @Published var enduranceWorkoutEntries =  [EnduranceWorkoutEntry]()
    @Published var settings = Settings()

    // MARK: Data Query Handling

    @Published var isInQuery = false

    /// Queries the database for data.
    /// Lock up UI with loading dialog via the isInQuery variable
    @MainActor
    func getData() async throws {
        self.isInQuery = true
        // TODO: replace with actual value change and DB calls
        try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        self.isInQuery = false
    }

    // MARK: Misc Data Getters

    /// Gets the highest possible distance for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    func getHighestEnduranceDistance(for name: String) -> Double {
        var result: Double = 0
        for entry in enduranceWorkoutEntries {
            let distance = entry.getConvertedDistanceUnit(for: settings.distanceUnit)
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Gets the highest possible weight for the given name.
    /// - Parameters:
    ///  - name the name of the exercise to check
    /// - Returns: the highest known value or 0 if none exists.
    func getHighestStrengthWeight(for name: String) -> Double {
        var result: Double = 0
        for entry in strengthWorkoutEntries {
            let distance = entry.getConvertedWeightUnit(for: settings.weightUnit)
            if distance > result {
                result = distance
            }
        }
        return result
    }

    /// Sorts all entries by date and returns in ascending order.
    /// - Returns: A list of workouts in ascending order
    func allWorkoutsSortedByDate() -> [WorkoutEntry] {
        var result = [WorkoutEntry]()
        result.append(contentsOf: strengthWorkoutEntries)
        result.append(contentsOf: enduranceWorkoutEntries)

        return result.sorted(by: {
            $0.timestamp.compare($1.timestamp) == .orderedAscending
        })
    }
}
