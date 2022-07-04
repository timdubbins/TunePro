//
//  SplashView.swift
//  Tuner
//
//  Created by Timothy Dubbins on 03/07/2022.
//

import SwiftUI

struct SplashView: View {
    @State private var animation = Animation.notStarted

    enum Animation {
        case notStarted
        case started
        case finished
    }

    var body: some View {
        FlipView(isFlipped: animation == .finished) {
            ZStack {
                Circle()
                    .foregroundColor(Color(UIColor.systemGray6))

                TuningForkShape()
                    .aspectRatio(contentMode: .fit)
                    .padding(50)
            }
            .opacity(animation == .started ? 1 : 0)
            .padding(5)

        } back: {
            TunerView()
        }
        .onAppear {
            withAnimation { animation = .started }
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 0.7) {
                    withAnimation { animation = .finished }
                }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
