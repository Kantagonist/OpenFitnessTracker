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

    @State private var chosenEntry = ""

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $chosenEntry) {
                ForEach(entries, id: \.self) { workoutEntry in
                    Text(workoutEntry)
                }
            }.pickerStyle(WheelPickerStyle())
            HStack(alignment: .center, spacing: 0) {
                Button("Add") {
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title)
                .padding(20)
                .foregroundColor(Color.green)
                Button("Delete") {
                    var i = 0
                    var iterator = entries.makeIterator()
                    while let current = iterator.next() {
                        print("chosenEntry: \(chosenEntry)")
                        if current == chosenEntry {
                            entries.remove(at: i)
                            break
                        }
                        i += 0
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.title)
                .frame(width: .infinity)
                .padding(20)
                .foregroundColor(Color.red)
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
