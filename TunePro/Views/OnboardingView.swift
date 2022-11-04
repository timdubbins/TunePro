//
//  OnboardingView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 31/10/2022.
//

import SwiftUI
import PageView

struct OnboardingView: View {
    let isFirstRun: (Bool) -> Void

    var body: some View {
        PageView {
            pageOne
            pageTwo
        }
        .font(.system(size: UIDevice.isPad ? 30 : 15, design: .monospaced))
    }

    var pageOne: some View {
        VStack {
            TuningForkShape()
                .scaledToFit()
                .frame(height: UIDevice.isPad ? 400 : 200)
                .padding(.bottom, 50)
            Text("thanks for choosing")
                .padding(.bottom, 1)
            Text("TunePro!")
                .padding(.bottom, 30)
        }
        .font(.system(size: UIDevice.isPad ? 40 : 20, design: .monospaced))
    }

    var pageTwo: some View {
        VStack(alignment: .center) {
            Text("getting started")
                .fontWeight(.semibold)
                .padding(.top, 40)
                .font(.system(size: UIDevice.isPad ? 60 : 30))
            VStack(alignment: .leading, spacing: 30) {
                Text("switch between ♯ or ♭ symbols by tapping the tuner")
                Text("turn the visualizer on and off by tapping the \(Image("visualizer-symbol")) button")
                Text("change the theme by tapping anywhere on the background")
            }
            .padding(.top)
            .padding(.horizontal, UIDevice.isPad ? 60 : 20)
            HStack {
                Spacer()
                Button {
                    isFirstRun(false)
                } label: {
                    Text("ok!")
                        .fontWeight(.semibold)
                        .font(.system(size: UIDevice.isPad ? 40 : 20))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(UIDevice.isPad ? 60 : 30)
                        .contentShape(Rectangle())
                }
                    .padding(.bottom, 40)
                    .padding(.top, UIDevice.isPad ? 100 : 70)
                    .padding(.trailing, UIDevice.isPad ? 110 : 50)
            }
        }
    }

    init(isFirstRun: @escaping (Bool) -> Void) {
        self.isFirstRun = isFirstRun
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView() { _ in }
            .preferredColorScheme(.dark)
    }
}
