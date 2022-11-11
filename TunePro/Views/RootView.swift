//
//  RootView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 03/07/2022.
//

import StoreKit
import SwiftUI

struct RootView: View {
    @EnvironmentObject var data: DataController

    @State private var animation = Animation.State.notStarted

    var background: some View {
        data.theme.backgroundColor
            .accessibilityAddTraits(.isButton)
            .accessibilityIdentifier("swapTheme")
        
            .onTapGesture {
                withAnimation(.linear(duration: 0.3)) {
                    data.nextTheme()
                }
            }
    }

    var body: some View {
        FlipView(
            axis: (x: -1, y: 1, z: 0),
            isFlipped: animation == .finished) {
                SplashView()
                    .opacity(animation == .started ? 1 : 0)
            } back: {
                TunerView()
                    .onAppear(perform: requestReview)
            }
            .padding(.top, 20)
            .padding(5)
            .background(background)
            .ignoresSafeArea()

            .onAppear {
                withAnimation { animation = .started }
                DispatchQueue.main
                    .asyncAfter(deadline: .now() + 0.7) {
                        withAnimation { animation = .finished }
                    }
            }
    }

    private func requestReview() {
        if data.appRunCount == 10 || data.appRunCount == 20 {
            DispatchQueue.main.async {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
    }
}
