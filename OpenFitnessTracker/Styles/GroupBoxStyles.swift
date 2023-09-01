//
//  GroupBoxStyles.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 01.09.23.
//

import SwiftUI

/// Custom GroupBoxStyle which sets the background to clear
struct TransparentGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.label.font(.headline)
                Spacer()
            }
            configuration.content
        }
        .frame(height: 300)
        .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
        .fill(.clear))
    }
}
