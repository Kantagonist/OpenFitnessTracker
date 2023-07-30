//
//  File.swift
//  OpenFitnessTracker
//
//  Created by Kantagonist on 30.07.23.
//

import Foundation
import SwiftUI

struct SelectedBorderShape: Shape {
    var sides: [Edge]
    var cornerRadius: CGFloat = 5.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        for side in sides {
            switch side {
            case .top:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case .bottom:
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            case .leading:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            case .trailing:
                path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            }
        }

        return path
    }
}
