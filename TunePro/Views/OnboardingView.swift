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
            pageThree
        }
    }

    var pageOne: some View {
        Text("Thanks for choosing TunePro!")
    }

    var pageTwo: some View {
        Text("tune ...")
    }

    var pageThree: some View {
        Text("continue")
            .font(.system(size: 15, design: .monospaced))
            .padding()
            .background(Color.pink)
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
