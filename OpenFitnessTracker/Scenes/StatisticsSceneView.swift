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
    
    @State private var maxStrengthWorkout = ""
    @State private var maxEnduranceWorkout = ""

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
