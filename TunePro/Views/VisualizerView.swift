//
//  VisualizerView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct VisualizerView: View {
    @EnvironmentObject var data: DataController

    let visualizer: Tuner.Visualizer

    var body: some View {
        ZStack {
            ForEach((0..<3), id: \.self) { number in
                WaveShape(visualizer.amplitude, visualizer.frequency, phase: visualizer.phase[number])
                    .stroke(data.theme.visualizerColor)
                    .opacity(visualizer.amplitude == 0 ? 0 : 0.8)
                    .animation(.linear(duration: 0.5), value: visualizer.amplitude)
            }
        }
        .padding(UIDevice.isPad ? 16 : 11)
        .rotationEffect(.degrees(90))
        .clipShape(Circle().inset(by: UIDevice.isPad ? 42 : 22))
    }

    init(_ visualizer: Tuner.Visualizer) {
        self.visualizer = visualizer
    }
}
