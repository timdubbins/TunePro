//
//  BezelView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct BezelView: View {
    let model: Tuner.Bezel
    
    var body: some View {
            ZStack {            
            WedgeShape(wedge: Wedge.topWedge)
                .foregroundColor(model.state == .tuned ? Color.green : Color.white)
            
            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .stroke(Color.white)
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
            
            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .foregroundColor(model.state == .tuned ? Color.green : getColor(wedgeNumber))
                .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
        }
    }

    init(_ model: Tuner.Bezel) { self.model = model }

    /// Returns the color for the given wedge.
    private func getColor(_ wedgeNumber: Int) -> Color {
        let distance = model.distance
        let sharpColor = Color.yellow
        let flatColor = Color.red
        let defaultColor = Color.clear

        switch wedgeNumber {
        case 0:
            return model.state == .sharp ? sharpColor : defaultColor
        case 1:
            return model.state == .sharp && distance > 0.18 ? sharpColor : defaultColor
        case 2:
            return model.state == .sharp && distance > 0.26 ? sharpColor : defaultColor
        case 3:
            return model.state == .sharp && distance > 0.34 ? sharpColor : defaultColor
        case 4:
            return model.state == .sharp && distance > 0.42 ? sharpColor : defaultColor
        case 5 :
            return model.state == .flat && distance < 0.58 ? flatColor : defaultColor
        case 6:
            return model.state == .flat && distance < 0.66 ? flatColor : defaultColor
        case 7:
            return model.state == .flat && distance < 0.74 ? flatColor : defaultColor
        case 8:
            return model.state == .flat && distance < 0.82 ? flatColor : defaultColor
        case 9:
            return model.state == .flat ? flatColor : defaultColor
        default:
            return defaultColor
        }
    }
}
