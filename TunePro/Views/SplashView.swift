//
//  SplashView.swift
//  TunePro
//
//  Created by Timothy Dubbins on 20/07/2022.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var tm: ThemeManager

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(tm.theme.face)

            TuningForkShape()
                .aspectRatio(contentMode: .fit)
                .padding(50)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
