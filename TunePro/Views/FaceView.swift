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

    var front: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(data.frequency)
                    .fontWeight(.semibold)

                Text("Hz")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Text(data.note)
                .fontWeight(.semibold)
                .font(.system(size: size.width * 1.4 / 3))

            VStack(alignment: .leading) {
                Text(data.symbol)
                    .fontWeight(.semibold)
                    .font(.system(size: size.width * 1.2 / 5))

                Text(data.octave)
                    .fontWeight(.semibold)
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
            isFlipped: data.showingSymbol,
            front: { front },
            back: { back }
        )
        .foregroundColor(tm.theme.accent)
        .animation(.linear, value: data.showingSymbol)
        .readSize { size = $0 }
    }

    init(_ data: Tuner.Face) { self.data = data }
}
