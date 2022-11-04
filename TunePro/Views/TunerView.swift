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
            .foregroundColor(tm.theme.faceColor)
    }

    var body: some View {
        ZStack {
            BezelView(vm.bezel)

            if vm.visualizerIsShowing {
                VisualizerView(vm.visualizer)
            }

            FaceView(vm.face)
        }
        .contentShape(Circle())
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("toggleSymbol")
        .onTapGesture(perform: vm.symbolToggle)

        .padding(10)
        .background(background)
        .overlay(
            Button {
                withAnimation {
                    vm.visualizerIsShowing.toggle()
                }
            } label: {
                Image(systemName: vm.visualizerIsShowing ? "waveform.circle" : "circle")
                    .rotationEffect(.radians(.pi * 0.5))
                    .foregroundColor(tm.theme.accentColor)
                    .font(UIDevice.isPad ? .largeTitle : .title3)
                    .padding()
            },
            alignment: .topTrailing)
        .padding(UIDevice.isPad ? 40 : 0)
        
        .onAppear(perform: vm.startPitchTap)
        .onDisappear(perform: vm.stopPitchTap)
        .alert(isPresented: $vm.showingAlert) {
            Alert(
                title: Text("TunePro needs microphone access to show the tuner"),
                message: Text("You can turn on microphone access in Settings > TunePro")
            )
        }
    }
}
