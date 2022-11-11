//
//  BezelView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct BezelView: View {
    @EnvironmentObject var data: DataController

    let bezel: Tuner.Bezel

    var body: some View {
        ZStack {
            WedgeShape(wedge: Wedge.topWedge)
                .foregroundColor(bezel.state == .tuned ? data.theme.tunedColor : data.theme.accentColor)

            WedgeShape(wedge: Wedge.topWedge)
                .stroke(data.theme.accentColor)

            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .foregroundColor(bezel.state == .tuned ? data.theme.tunedColor : getColor(wedgeNumber))
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))

            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .stroke(data.theme.accentColor)
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
        }
    }

    init(_ bezel: Tuner.Bezel) { self.bezel = bezel }

    /// Returns the color for the given wedge.
    private func getColor(_ wedgeNumber: Int) -> Color {
        let distance = bezel.distance
        let sharpColor = data.theme.sharpColor
        let flatColor = data.theme.flatColor
        let defaultColor = Color.clear

        switch wedgeNumber {
        case 0:
            return bezel.state == .sharp ? sharpColor : defaultColor
        case 1:
            return bezel.state == .sharp && distance > 0.18 ? sharpColor : defaultColor
        case 2:
            return bezel.state == .sharp && distance > 0.26 ? sharpColor : defaultColor
        case 3:
            return bezel.state == .sharp && distance > 0.34 ? sharpColor : defaultColor
        case 4:
            return bezel.state == .sharp && distance > 0.42 ? sharpColor : defaultColor
        case 5 :
            return bezel.state == .flat && distance < 0.58 ? flatColor : defaultColor
        case 6:
            return bezel.state == .flat && distance < 0.66 ? flatColor : defaultColor
        case 7:
            return bezel.state == .flat && distance < 0.74 ? flatColor : defaultColor
        case 8:
            return bezel.state == .flat && distance < 0.82 ? flatColor : defaultColor
        case 9:
            return bezel.state == .flat ? flatColor : defaultColor
        default:
            return defaultColor
        }
    }
}
