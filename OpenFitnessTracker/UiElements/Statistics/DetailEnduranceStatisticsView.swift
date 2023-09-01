//
//  DetailEnduranceStatisticsView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 12.08.23.
//

import SwiftUI
import Charts

/// Shows detailed workout data of all given endurance entries.
struct DetailEnduranceStatisticsView: View {

    let name: String
    let distanceUnit: DistanceUnit
    let workouts: [EnduranceWorkoutEntry]

    var body: some View {
        ScrollView {
            VStack( alignment: .leading, spacing: 10.0) {
                Text(name)
                    .font(.largeTitle)
                GroupBox(label: Text("Distances")) {
                    Chart(workouts) { workout in
                        LineMark(
                            x: .value("Date", workout.timestamp, unit: .day),
                            y: .value("Distance", workout.getConvertedDistanceUnit(for: distanceUnit))
                        )
                    }
                    .chartYAxisLabel(position: .trailing, alignment: .center) {
                        Text("Weight")
                    }
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Distance in \(distanceUnit.rawValue)")
                    }
                }
                GroupBox(label: Text("Times")) {
                    Chart(workouts) { workout in
                        LineMark(
                            x: .value("Date", workout.timestamp, unit: .day),
                            y: .value("Time", workout.durationInMilliseconds / 1000)
                        )
                    }
                    .chartYAxisLabel(position: .trailing, alignment: .center) {
                        Text("Weight")
                    }
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Time in seconds")
                    }
                }
            }
            .padding()
            .groupBoxStyle(TransparentGroupBoxStyle())
        }
    }
}

// MARK: Preview

struct DetailEnduranceStatisticsView_Previews: PreviewProvider {

    private static let name = "Demo Entry"
    private static let distanceUnit = DistanceUnit.km
    private static let workouts = {
        var result = [EnduranceWorkoutEntry]()
        for i in 0..<10 {
            result.append(EnduranceWorkoutEntry(
                name: name,
                timestamp: Date().addingTimeInterval(TimeInterval(86400 * i)),
                durationInMilliseconds: UInt64(i % 3 == 0 ? i * 3600 : i * 1200),
                distance: i % 2 == 0 ? Double(i) * 2.0 : Double(i) * 1.0,
                recordedDistanceUnit: distanceUnit)
            )
        }
        return result
    }()

    static var previews: some View {
        DetailEnduranceStatisticsView(
            name: name,
            distanceUnit: distanceUnit,
            workouts: workouts
        )
    }
}
