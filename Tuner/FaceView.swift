//
//  FaceView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 25/06/2022.
//

import SwiftUI

struct FaceView: View {
    let model: Tuner.Face

    @State private var size = CGSize()

    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Text(model.frequency)
                    .fontWeight(.semibold)

                Text("Hz")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)

            Text(model.note)
                .fontWeight(.semibold)
                .font(.system(size: size.width * 1.4 / 3))

            VStack(alignment: .leading) {
                Text(model.symbol)
                    .fontWeight(.semibold)
                    .font(.system(size: size.width * 1.2 / 5))

                Text(model.octave)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundColor(.white)
        .readSize { size = $0 }
    }

    init(_ model: Tuner.Face) { self.model = model }
}
