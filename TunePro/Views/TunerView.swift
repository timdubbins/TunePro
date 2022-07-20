//
//  TunerView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct TunerView: View {
    @StateObject private var vm = ViewModel()
    @EnvironmentObject var tm: ThemeManager

    var background: some View {
        Circle()
            .foregroundColor(tm.theme.face)
    }

    var body: some View {
        ZStack {
            BezelView(vm.bezel)
            VisualizerView(vm.visualizer)
            FaceView(vm.face)
        }
        .contentShape(Circle())
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("toggleSymbol")
        .onTapGesture(perform: vm.symbolToggle)

        .padding(10)
        .background(background)
        
        .onAppear(perform: vm.startPitchTap)
        .onDisappear(perform: vm.stopPitchTap)
    }
}
