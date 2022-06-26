//
//  VisualizerView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct VisualizerView: View {
    let model: Tuner.Visualizer

    var body: some View {
        ZStack {
            ForEach((0..<3), id: \.self) { number in
                WaveShape(model.amplitude, model.frequency, phase: model.phase[number])
                    .stroke(Color.pink)
                    .opacity(model.amplitude == 0 ? 0 : 0.8)
                    .animation(.linear(duration: 0.5), value: model.amplitude)
            }
        }
        .padding(11)
        .rotationEffect(.degrees(90))
        .clipShape(Circle().inset(by: 22))
    }

    init(_ model: Tuner.Visualizer) { self.model = model }
}
