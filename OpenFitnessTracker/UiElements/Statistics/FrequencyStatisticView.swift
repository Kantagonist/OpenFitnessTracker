//
//  FrequencyStatisticView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 11.08.23.
//

import SwiftUI
import Charts

/// Shows a bar graph which displays how many workouts were had per week.
struct FrequencyStatisticView: View {

    ///  a set of workouts, sorted by date
    let workouts: [WorkoutEntry]

    var body: some View {
        Chart {
            let currentYear = Calendar.current.dateComponents([.year], from: Date()).year!
            let amountsPerDate = getTrainingsPerWeek(of: currentYear)
            ForEach(workouts) { workout in
                let weekNumber = Calendar.current.dateComponents([.weekOfYear], from: workout.timestamp).weekOfYear!
                LineMark(
                    x: .value("Week", weekNumber),
                    y: .value("Amount", amountsPerDate[weekNumber]!)
                )
            }
        }
        .chartYScale(domain: [0, 8])
        .chartYAxis {
            AxisMarks(values: [0, 2, 4, 6, 8])
        }
        .chartXScale(domain: [0, 52])
        // TODO: automatic just doesn't work for some reason. Find a better solution.
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 20))
        }
    }
    
    /// Calculates the training per calendar week.
    /// Gives back a comprehensive dict for display in bar graph.
    /// - Parameters:
    ///  - year The year from which to show as an Int
    /// - Returns: A dict with week, amount kv-pairs
    private func getTrainingsPerWeek(of year: Int) -> [Int: Int] {
        var result = [Int: Int]()
        for i in 1...52 {
            result[i] = 0
        }

        for entry in workouts {
            // converts date into simple yyyy-mm-dd format
            let convertedDate = Calendar.current.dateComponents(
                [.year, .weekOfYear],
                from: entry.timestamp
            )
            // adjust entries
            if convertedDate.year == year {
                if result.keys.contains(convertedDate.weekOfYear!) {
                    result[convertedDate.weekOfYear!]! += 1
                } else {
                    result[convertedDate.weekOfYear!] = 1
                }
            }
        }
        return result
    }
}

// MARK: Preview

struct FrequencyStatisticView_Previews: PreviewProvider {
    
    static func getWorkouts(amount: Int) -> [WorkoutEntry] {
        var workouts = [WorkoutEntry]()
        let date = Date.now
        for i in 0..<amount {
            if i % 5 == 0 {
                continue
            }
            workouts.append(
                WorkoutEntry(
                    name: "\(i).w",
                    timestamp: Calendar.current.date(byAdding: .day, value: -i, to: date)!
                )
            )
        }
        return workouts.sorted(by: {
            $0.timestamp.compare($1.timestamp) == .orderedAscending
        })
    }

    // TODO: find fix for why crashes with dates before current year.
    static var previews: some View {
        FrequencyStatisticView(workouts: getWorkouts(amount: 200))
            .frame(height: 200)
            .padding(20)
    }
}
