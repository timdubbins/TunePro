//
//  ContentView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 03/07/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var tm: ThemeManager
    
    @State private var animation = Animation.State.notStarted

    var background: some View {
        tm.theme.background
            .accessibilityAddTraits(.isButton)
            .accessibilityIdentifier("swapTheme")
        
            .onTapGesture {
                withAnimation(.linear(duration: 0.3)) {
                    tm.swapTheme()
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
}
