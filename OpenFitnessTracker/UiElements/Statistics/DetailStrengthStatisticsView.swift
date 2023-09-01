//
//  DetailStrengthStatisticsView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 12.08.23.
//

import SwiftUI
import Charts

struct DetailStrengthStatisticsView: View {
    
    let name: String
    let weightUnit: WeightUnit
    let workouts: [StrengthWorkoutEntry]

    // MARK: View

    var body: some View {
        ScrollView {
            VStack( alignment: .leading, spacing: 10.0) {
                Text(name)
                    .font(.largeTitle)
                GroupBox(label: Text("Daily Max Weights")) {
                    Chart(workouts) { workout in
                        LineMark(
                            x: .value("Date", workout.timestamp, unit: .day),
                            y: .value("Weight", workout.getConvertedWeightUnit(for: weightUnit))
                        )
                    }
                    .chartYAxisLabel(position: .trailing, alignment: .center) {
                        Text("Weight")
                    }
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Date")
                    }
                }
                GroupBox(label: Text("Daily Combined Sets")) {
                    Chart(workouts) { workout in
                        LineMark(
                            x: .value("Date", workout.timestamp, unit: .day),
                            y: .value("Sets", workout.sets * workout.reps)
                        )
                    }
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Date")
                    }
                    .chartYAxisLabel(position: .trailing, alignment: .center) {
                        Text("Sets")
                    }
                   
                }
            }
            .padding()
            .groupBoxStyle(TransparentGroupBoxStyle())
        }
    }
}

// MARK: Preview

struct DetailStrengthStatisticsView_Previews: PreviewProvider {
    
    private static let name = "Demo Entry"
    private static let weightUnit = WeightUnit.kg
    private static let workouts = {
        var result = [StrengthWorkoutEntry]()
        for i in 0..<10 {
            result.append(StrengthWorkoutEntry(
                name: name,
                timestamp: Date().addingTimeInterval(TimeInterval(86400 * i)),
                sets: Int.random(in: 2...3),
                reps: Int.random(in: 3...5),
                weight: i % 2 == 0 ? Double(i) * 2.0 : Double(i) * 1.0,
                recordedWeightUnit: weightUnit)
            )
        }
        return result
    }()
    
    static var previews: some View {
        DetailStrengthStatisticsView(
            name: name,
            weightUnit: weightUnit,
            workouts: workouts
        )
    }
}
