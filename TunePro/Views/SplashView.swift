//
//  SplashView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 11/11/2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(tm.theme.faceColor)

            TuningForkShape()
                .aspectRatio(contentMode: .fit)
                .padding(UIDevice.isPad ? 140 : 60)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
