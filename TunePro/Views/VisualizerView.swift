//
//  VisualizerView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct VisualizerView: View {
    @EnvironmentObject var tm: ThemeManager

    let vm: Tuner.Visualizer

    var body: some View {
        ZStack {
            ForEach((0..<3), id: \.self) { number in
                WaveShape(vm.amplitude, vm.frequency, phase: vm.phase[number])
                    .stroke(tm.theme.vizualiser)
                    .opacity(vm.amplitude == 0 ? 0 : 0.8)
                    .animation(.linear(duration: 0.5), value: vm.amplitude)
            }
        }
        .padding(11)
        .rotationEffect(.degrees(90))
        .clipShape(Circle().inset(by: 22))
    }

    init(_ viewModel: Tuner.Visualizer) { vm = viewModel }
}
