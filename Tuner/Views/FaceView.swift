//
//  FaceView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import SwiftUI

struct FaceView: View {
    @EnvironmentObject var tm: ThemeManager
    let vm: Tuner.Face

    @State private var size = CGSize()

    var front: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(vm.frequency)
                    .fontWeight(.semibold)

                Text("Hz")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Text(vm.note)
                .fontWeight(.semibold)
                .font(.system(size: size.width * 1.4 / 3))

            VStack(alignment: .leading) {
                Text(vm.symbol)
                    .fontWeight(.semibold)
                    .font(.system(size: size.width * 1.2 / 5))

                Text(vm.octave)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var back: some View {
        Text(vm.symbol)
            .fontWeight(.semibold)
            .font(.system(size: size.width * 1.4 / 3))
    }

    var body: some View {
        FlipView(
            isFlipped: vm.showingSymbol,
            front: { front },
            back: { back }
        )
        .foregroundColor(tm.theme.accent)
        .animation(.linear, value: vm.showingSymbol)
        .readSize { size = $0 }
    }

    init(_ viewModel: Tuner.Face) { vm = viewModel }
}
