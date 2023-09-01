//
//  StatisticsSceneView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 23.05.23.
//

import SwiftUI

/// Page which displays certain user statistics pulled form existing workouts
struct StatisticsSceneView: View {

    @StateObject private var viewModel = ViewModel.getInstance()
    @State private var presentPopover = false

    // MARK: Main View

    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Max Values")) {
                    VStack(spacing: 5) {
                        ForEach(viewModel.settings.endWorkouts, id: \.self) { workout in
                            HStack {
                                Text(workout)
                                Spacer()
                                Text("\(String(format: "%.4f", viewModel.getHighestEnduranceDistance(for: workout))) \(viewModel.settings.distanceUnit.rawValue)")
                            }
                        }
                    }
                    VStack(spacing: 5) {
                        ForEach(viewModel.settings.strWorkouts, id: \.self) { workout in
                            HStack {
                                Text(workout)
                                Spacer()
                                Text("\(String(format: "%.2f", viewModel.getHighestStrengthWeight(for: workout))) \(viewModel.settings.weightUnit.rawValue)")
                            }
                        }
                    }
                }

                Section(header: Text("Frequency")) {
                    FrequencyStatisticView(workouts: viewModel.allWorkoutsSortedByDate())
                }
                
                Section(header: Text("Details")) {
                    ForEach(viewModel.settings.endWorkouts, id: \.self) { workout in
                        Button(workout) {
                            presentPopover = true
                        }.popover(isPresented: $presentPopover) {
                            DetailEnduranceStatisticsView(
                                name: workout,
                                distanceUnit: viewModel.settings.distanceUnit,
                                workouts: viewModel.enduranceWorkoutEntries.filter(
                                    { $0.name == workout }
                                )
                            )
                        }
                    }
                    .foregroundColor(.blue)
                    ForEach(viewModel.settings.strWorkouts, id: \.self) { workout in
                        Button(workout) {
                            presentPopover = true
                        }.popover(isPresented: $presentPopover) {
                            DetailStrengthStatisticsView(
                                name: workout,
                                weightUnit: viewModel.settings.weightUnit,
                                workouts: viewModel.strengthWorkoutEntries.filter(
                                    { $0.name == workout }
                                )
                            )
                        }
                    }
                    .foregroundColor(.blue)
                }
            }
            .foregroundColor(viewModel.settings.textColor)
            .navigationBarTitle("Statistics")
        }
    }
}

// MARK: Preview

struct PersonalInformationSceneView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSceneView()
    }
}
