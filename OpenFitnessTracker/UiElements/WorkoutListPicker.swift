//
//  WorkoutListPicker.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 04.08.23.
//

import SwiftUI

/// A small display, which allows the user to remove and add elements to a given list.
struct WorkoutListPicker: View {

    @Binding var entries: [String]
    @State private var chosenEntry = 0
    @State private var showTextInputDialog = false
    @State private var newEntry = ""

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $chosenEntry) {
                ForEach(0..<entries.count, id: \.self) { index in
                    Text(entries[index])
                }
            }.pickerStyle(WheelPickerStyle())

            HStack(alignment: .center, spacing: 0) {
                Button("Add") {
                    showTextInputDialog = true
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title)
                .padding(20)
                .foregroundColor(Color.green)

                Button("Delete") {
                    if entries.count > chosenEntry {
                        entries.remove(at: chosenEntry)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title)
                .frame(width: .infinity)
                .padding(20)
                .foregroundColor(Color.red)
            }
            .alert("Add New Entry", isPresented: $showTextInputDialog) {
                TextField("", text: $newEntry)
                Button("Confirm", role: .cancel) {
                    entries.append(newEntry)
                    newEntry = ""
                }
            }
        }
    }
}

// MARK: Preview

let demoEntries = [
    "one",
    "two",
    "three",
    "threee",
    "threeee"
]

struct WorkoutListPicker_Previews: PreviewProvider {

    @State private static var entries = demoEntries

    static var previews: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            WorkoutListPicker(entries: $entries)
                Spacer()
                    .frame(width: 20)
        }
    }
}
