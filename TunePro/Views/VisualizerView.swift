//
//  VisualizerView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct VisualizerView: View {
    @EnvironmentObject var tm: ThemeManager

    let data: Tuner.Visualizer

    var body: some View {
        ZStack {
            ForEach((0..<3), id: \.self) { number in
                WaveShape(data.amplitude, data.frequency, phase: data.phase[number])
                    .stroke(tm.theme.visualizerColor)
                    .opacity(data.amplitude == 0 ? 0 : 0.8)
                    .animation(.linear(duration: 0.5), value: data.amplitude)
            }
        }
        .padding(11)
        .rotationEffect(.degrees(90))
        .clipShape(Circle().inset(by: 22))
    }

    init(_ data: Tuner.Visualizer) { self.data = data }
}
