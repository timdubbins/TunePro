//
//  FaceView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import SwiftUI

struct FaceView: View {
    @EnvironmentObject var data: DataController

    @State private var size = CGSize()

    let face: Tuner.Face
    let font: Font

    var front: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(face.frequency)
                    .fontWeight(.semibold)

                Text("Hz")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(font)

            Text(face.note)
                .fontWeight(.semibold)
                .font(.system(size: size.width * 1.4 / 3))

            VStack(alignment: .leading) {
                Text(face.symbol)
                    .fontWeight(.semibold)
                    .font(.system(size: size.width * 1.2 / 5))

                Text(face.octave)
                    .fontWeight(.semibold)
                    .font(font)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var back: some View {
        Text(face.symbol)
            .fontWeight(.semibold)
            .font(.system(size: size.width * 1.4 / 3))
    }

    var body: some View {
        FlipView(
            axis: (x: -1, y: 1, z: 0),
            isFlipped: face.showingSymbol,
            front: { front },
            back: { back }
        )
        .foregroundColor(data.theme.accentColor)
        .animation(.linear, value: face.showingSymbol)
        .readSize { size = $0 }
    }

    init(_ face: Tuner.Face) {
        self.face = face
        font = UIDevice.isPad ? .title : .body
    }
}
