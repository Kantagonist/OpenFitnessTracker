//
//  StrengthEntryStatisticsBox.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 27.07.23.
//

import SwiftUI

/// A small box which is read-only.
/// It displays information from a given ``StrengthWorkoutEntry``.
struct StrengthEntryBoxView: View {

    let entry: StrengthWorkoutEntry
    @EnvironmentObject private var viewModel: ViewModel

    var body: some View {
        VStack(spacing: 0) {
            WorkoutEntryHeaderView(entry: entry)
            HStack {
                Spacer()
                    .frame(width: 10)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("Sets: \(entry.sets)")
                            .foregroundColor(viewModel.settings.textColor)
                            .font(.system(size: 20))
                            .padding(16.0)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                SelectedBorderShape(
                                    sides: [.leading, .trailing, .bottom]
                                )
                                .stroke(viewModel.settings.textColor, lineWidth: 1.0)
                            )
                        Text("Reps: \(entry.reps)")
                            .foregroundColor(viewModel.settings.textColor)
                            .font(.system(size: 20))
                            .padding(16.0)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                SelectedBorderShape(
                                    sides: [.trailing, .bottom]
                                )
                                .stroke(viewModel.settings.textColor, lineWidth: 1.0)
                            )
                    }
                    Text("\(String(format: "%.2f", entry.getConvertedWeightUnit(for: viewModel.settings.weightUnit))) \(viewModel.settings.weightUnit.rawValue)")
                        .foregroundColor(viewModel.settings.textColor)
                        .font(.system(size: 20))
                        .padding(16.0)
                        .frame(maxWidth: .infinity)
                        .overlay(
                            SelectedBorderShape(
                                sides: [.leading, .trailing, .bottom]
                            )
                            .stroke(viewModel.settings.textColor, lineWidth: 1.0)
                        )
                }
                Spacer()
                    .frame(width: 30)
            }
        }
    }
}

// MARK: Preview

private let demoEntry = StrengthWorkoutEntry(
    name: "Bench Press",
    timestamp: Date(),
    sets: 3,
    reps: 8,
    weight: 30.0,
    recordedWeightUnit: .kg
)

struct StrengthEntryStatisticsBox_Previews: PreviewProvider {

    static var previews: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            StrengthEntryBoxView(entry: demoEntry)
                .environmentObject(ViewModel.getInstance())
            Spacer()
                .frame(width: 20)
        }
    }
}
