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
        .font(.system(size: 15, design: .monospaced))
    }

    var pageOne: some View {
        VStack {
            TuningForkShape()
                .scaledToFit()
                .frame(height: 200)
                .padding(.bottom, 50)
            Text("thanks for choosing")
                .padding(.bottom, 1)
            Text("TunePro!")
                .padding()
        }
        .font(.system(size: 20, design: .monospaced))
        .padding(.bottom, 50)
    }

    var pageTwo: some View {
        VStack(alignment: .center) {
            Text("getting started")
                .fontWeight(.semibold)
                .padding(.top, 30)
                .padding()
                .font(.system(size: 30))
            VStack(alignment: .leading, spacing: 30) {
                Text("switch between ♯ or ♭ symbols by tapping the tuner")
                Text("turn the visualizer on and off by tapping the \(Image("visualizer-symbol")) button")
                Text("change the theme by tapping anywhere on the background")
            }
            .padding()
            HStack {
                Spacer()
                continueButton
                    .padding(.bottom, 40)
                    .padding(.trailing, 50)
                    .padding(.top, 70)
            }
        }
    }

    var continueButton: some View {
        Text("ok!")
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .contentShape(Rectangle())
            .onTapGesture {
                isFirstRun(false)
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
