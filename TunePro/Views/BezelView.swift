//
//  BezelView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct BezelView: View {
    @EnvironmentObject var tm: ThemeManager
    let data: Tuner.Bezel

    var body: some View {
        ZStack {
            WedgeShape(wedge: Wedge.topWedge)
                .foregroundColor(data.state == .tuned ? tm.theme.tunedColor : tm.theme.accentColor)

            WedgeShape(wedge: Wedge.topWedge)
                .stroke(tm.theme.accentColor)

            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .foregroundColor(data.state == .tuned ? tm.theme.tunedColor : getColor(wedgeNumber))
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))

            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .stroke(tm.theme.accentColor)
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
        }
    }

    init(_ data: Tuner.Bezel) { self.data = data }

    /// Returns the color for the given wedge.
    private func getColor(_ wedgeNumber: Int) -> Color {
        let distance = data.distance
        let sharpColor = tm.theme.sharpColor
        let flatColor = tm.theme.flatColor
        let defaultColor = Color.clear

        switch wedgeNumber {
        case 0:
            return data.state == .sharp ? sharpColor : defaultColor
        case 1:
            return data.state == .sharp && distance > 0.18 ? sharpColor : defaultColor
        case 2:
            return data.state == .sharp && distance > 0.26 ? sharpColor : defaultColor
        case 3:
            return data.state == .sharp && distance > 0.34 ? sharpColor : defaultColor
        case 4:
            return data.state == .sharp && distance > 0.42 ? sharpColor : defaultColor
        case 5 :
            return data.state == .flat && distance < 0.58 ? flatColor : defaultColor
        case 6:
            return data.state == .flat && distance < 0.66 ? flatColor : defaultColor
        case 7:
            return data.state == .flat && distance < 0.74 ? flatColor : defaultColor
        case 8:
            return data.state == .flat && distance < 0.82 ? flatColor : defaultColor
        case 9:
            return data.state == .flat ? flatColor : defaultColor
        default:
            return defaultColor
        }
    }
}
