//
//  FlipView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 15/02/2022.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
    var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back

    var body: some View {
        ZStack {
            front()
                .rotation3DEffect(.degrees(isFlipped == true ? 180 : 0), axis: axis)
                .opacity(isFlipped == true ? 0 : 1)
                .accessibility(hidden: isFlipped == true)

            back()
                .rotation3DEffect(.degrees(isFlipped == true ? 0 : -180), axis: axis)
                .opacity(isFlipped == true ? 1 : -1)
                .accessibility(hidden: isFlipped == false)
        }
    }

    init(axis: (x: CGFloat, y: CGFloat, z: CGFloat), isFlipped: Bool = false, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.axis = axis
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }
}
