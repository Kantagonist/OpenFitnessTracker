//
//  FrequencyStatisticView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 11.08.23.
//

import SwiftUI
import Charts

/// Shows a bar graph which displays how many workouts were had per day.
struct FrequencyStatisticView: View {

    ///  a set of workouts, sorted by date
    let workouts: [WorkoutEntry]

    var body: some View {
        Chart {
            let amountsPerDate = getAmountOfEachDate()
            ForEach(workouts) { workout in
                LineMark(
                    x: .value("Date", workout.timestamp),
                    y: .value("Amount", amountsPerDate[workout.timestamp]!)
                )
            }
        }
    }
    
    /// Returns the amount of times, each given date occurs.
    private func getAmountOfEachDate() -> [Date: Int] {
        var result = [Date: Int]()
        for entry in workouts {
            if result.keys.contains(entry.timestamp) {
                result[entry.timestamp]! += 1
            } else {
                result[entry.timestamp] = 1
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
            if i % 2 == 0 {
                workouts.append(
                    WorkoutEntry(
                        name: "\(i).w",
                        timestamp: Calendar.current.date(byAdding: .day, value: -i, to: date)!
                    )
                )
            }
            if i % 3 == 0 {
                workouts.append(
                    WorkoutEntry(
                        name: "\(i).w",
                        timestamp: Calendar.current.date(byAdding: .day, value: -i, to: date)!
                    )
                )
            }
        }
        return workouts.sorted(by: {
            $0.timestamp.compare($1.timestamp) == .orderedAscending
        })
    }

    
    static var previews: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            FrequencyStatisticView(workouts: getWorkouts(amount: 10))
                .frame(height: 200)
            Spacer()
                .frame(width: 20)
        }
    }
}
