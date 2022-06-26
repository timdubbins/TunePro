//
//  TunerView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct TunerView: View {
    @StateObject private var vm = ViewModel()

    var body: some View {
        ZStack {
            BezelView(vm.bezel)
            VisualizerView(vm.visualizer)
            FaceView(vm.face)
        }
        .padding(10)
        .background(
            Circle()
                .padding(5)
                .foregroundColor(Color(UIColor.systemGray6)))
        .onTapGesture(perform: vm.symbolToggle)
        .onAppear(perform: vm.startPitchTap)
        .onDisappear(perform: vm.stopPitchTap)
    }
}

struct TunerViewPreview: PreviewProvider {
    static var previews: some View {
        TunerView()
            .background(Color.black)
    }
}
