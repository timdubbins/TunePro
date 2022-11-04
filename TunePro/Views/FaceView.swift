//
//  FaceView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import SwiftUI

struct FaceView: View {
    @EnvironmentObject var tm: ThemeManager
    let data: Tuner.Face

    @State private var size = CGSize()

    let font: Font

    var front: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(data.frequency)
                    .fontWeight(.semibold)

                Text("Hz")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(font)

            Text(data.note)
                .fontWeight(.semibold)
                .font(.system(size: size.width * 1.4 / 3))

            VStack(alignment: .leading) {
                Text(data.symbol)
                    .fontWeight(.semibold)
                    .font(.system(size: size.width * 1.2 / 5))

                Text(data.octave)
                    .fontWeight(.semibold)
                    .font(font)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var back: some View {
        Text(data.symbol)
            .fontWeight(.semibold)
            .font(.system(size: size.width * 1.4 / 3))
    }

    var body: some View {
        FlipView(
            axis: (x: -1, y: 1, z: 0),
            isFlipped: data.showingSymbol,
            front: { front },
            back: { back }
        )
        .foregroundColor(tm.theme.accentColor)
        .animation(.linear, value: data.showingSymbol)
        .readSize { size = $0 }
    }

    init(_ data: Tuner.Face) {
        self.data = data
        font = UIDevice.isPad ? .title : .body
    }
}
