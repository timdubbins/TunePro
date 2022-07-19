//
//  FlipView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 15/02/2022.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back

    var body: some View {
        ZStack {
            front()
                .rotation3DEffect(.degrees(isFlipped == true ? 180 : 0), axis: (x: -1, y: 1, z: 0))
                .opacity(isFlipped == true ? 0 : 1)
                .accessibility(hidden: isFlipped == true)

            back()
                .rotation3DEffect(.degrees(isFlipped == true ? 0 : -180), axis: (x: -1, y: 1, z: 0))
                .opacity(isFlipped == true ? 1 : -1)
                .accessibility(hidden: isFlipped == false)
        }
    }

    init(isFlipped: Bool = false, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }
}
