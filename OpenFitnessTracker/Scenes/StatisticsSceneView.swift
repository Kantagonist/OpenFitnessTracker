//
//  PersonalInformationSceneView.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 23.05.23.
//

import SwiftUI

/// Small overview on user
struct StatisticsSceneView: View {
    var body: some View {
        Text("Under construction")
    }
}

// MARK: Preview

/// Example user
let previewExamplePerson = Person(
    foto: UIImage(imageLiteralResourceName: "person_icon"),
    name: "Max Mustermann",
    birthdate: Date.now
)

struct PersonalInformationSceneView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSceneView()
    }
}

