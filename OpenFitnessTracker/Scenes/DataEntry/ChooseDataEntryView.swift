//
//  ChooseDataEntryView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 28.07.23.
//

import SwiftUI

/// A parent Scene, which lets the user decide which entry to create via a picker at the top
struct ChooseDataEntryView: View {

    @EnvironmentObject private var viewModel: ViewModel
    @Binding var isPresented: Bool

    @State private var entryShown: EntryType = .strength

    // MARK: View

    var body: some View {
        VStack {
            Picker("", selection: $entryShown) {
                ForEach(EntryType.allCases, id: \.self) { entryName in
                    Text("\(entryName.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            .padding(EdgeInsets(top: 16.0, leading: 0.0, bottom: 16.0, trailing: 0.0))
            switch entryShown {
            case .strength:
                StrengthWorkoutEntryView(
                    isPresented: $isPresented
                )
            case .endurance:
                EnduranceWorkoutEntryView(
                    isPresented: $isPresented
                )
            }
        }
    }
}

// MARK: Preview

struct ChooseDataEntryView_Previews: PreviewProvider {

    @State private static var present = true

    static var previews: some View {
        ChooseDataEntryView(
            isPresented: $present
        )
            .environmentObject(ViewModel.getInstance())
    }
}
