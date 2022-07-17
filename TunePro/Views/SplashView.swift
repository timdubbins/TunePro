//
//  SplashView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 03/07/2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var tm: ThemeManager
    @State private var animation = Animation.notStarted
    let data: Data

    enum Animation {
        case notStarted
        case started
        case finished
    }

    var body: some View {
        FlipView(isFlipped: animation == .finished) {
            ZStack {
                Circle()
                    .foregroundColor(tm.theme.face)

                TuningForkShape()
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
            }
            .opacity(animation == .started ? 1 : 0)

        } back: {
            TunerView(data: data)
        }
        .padding(.top, 20)
        .padding(5)
        .background(tm.theme.background)
        .ignoresSafeArea()

        .onAppear {
            withAnimation { animation = .started }
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 0.7) {
                    withAnimation { animation = .finished }
                }
        }
    }

    init(data: Data) {
        self.data = data
    }
}
