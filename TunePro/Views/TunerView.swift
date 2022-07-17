//
//  TunerView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct TunerView: View {
    @StateObject private var vm: ViewModel
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        ZStack {
            BezelView(vm.bezel)
            VisualizerView(vm.visualizer)
            FaceView(vm.face)
        }
        .padding(10)
        .background(
            Circle()
                .foregroundColor(tm.theme.face))
        .onTapGesture(perform: vm.symbolToggle)
        .onAppear(perform: vm.startPitchTap)
        .onDisappear(perform: vm.stopPitchTap)
    }

    init(data: Data) {
        let viewModel = ViewModel(data: data)
        _vm = StateObject(wrappedValue: viewModel)
    }
}
