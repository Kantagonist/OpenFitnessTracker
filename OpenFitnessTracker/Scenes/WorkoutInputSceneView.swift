//
//  WorkoutInputSceneView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 24.05.23.
//

import SwiftUI

/// Scene which allows the user to input data into the system
struct WorkoutInputSceneView: View {

    /// Source of truth for workout-entries
    @StateObject private var viewModel = ViewModel.getInstance()

    /// Boolean to control popover workout entry screen trigger
    @State private var isShowingEntryForm = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if viewModel.strengthWorkoutEntries.count <= 0 {
                        HStack {
                            Text("No Entries Yet...")
                            Spacer()
                        }
                    } else {
                        ForEach(viewModel.strengthWorkoutEntries) { strengthWorkoutEntry in
                            StrengthEntryBoxView(
                                entry: strengthWorkoutEntry,
                                settings: viewModel.settings
                            )
                        }
                    }
                }
            }.padding(16)
            Button("+") {
                isShowingEntryForm = true
            }.popover(isPresented: $isShowingEntryForm) {
                StrengthWorkoutEntryView(
                    existingEntries: $viewModel.strengthWorkoutEntries,
                    isPresented: $isShowingEntryForm,
                    settings: viewModel.settings
                )
            }
            .frame(width: 50.0, height: 50.0)
                .foregroundColor(Color.white)
                .background(Color.gray)
                .cornerRadius(32.0)
                .safeAreaInset(edge: .top, content: {})
        }
    }
}

// MARK: Preview

struct WorkoutInputSceneView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutInputSceneView()
    }
}
