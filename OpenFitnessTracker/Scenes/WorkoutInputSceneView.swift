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
    /// Shows which entries to show
    @State private var entryShown: EntryType = .strength

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10.0) {
                    // Picker for choosing which entries to see
                    Picker("", selection: $entryShown) {
                        ForEach(EntryType.allCases, id: \.self) { entryName in
                            Text("\(entryName.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(EdgeInsets(top: 16.0, leading: 0.0, bottom: 16.0, trailing: 0.0))

                    // Render chosen entries
                    switch entryShown {
                    case .strength:
                        if viewModel.strengthWorkoutEntries.isEmpty {
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
                    case .endurance:
                        if viewModel.enduranceWorkoutEntries.isEmpty {
                            HStack {
                                Text("No Entries Yet...")
                                Spacer()
                            }
                        } else {
                            ForEach(viewModel.enduranceWorkoutEntries) { enduranceWorkoutEntry in
                                EnduranceEntryBoxView(
                                    entry: enduranceWorkoutEntry,
                                    settings: viewModel.settings
                                )
                            }
                        }
                    }
                }
            }
            .padding(16)
            .environmentObject(viewModel)

            Button("+") {
                isShowingEntryForm = true
            }.popover(isPresented: $isShowingEntryForm) {
                ChooseDataEntryView(
                    existingStrengthEntries: $viewModel.strengthWorkoutEntries,
                    existingEnduranceEntries: $viewModel.enduranceWorkoutEntries,
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
