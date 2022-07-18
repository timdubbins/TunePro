//
//  Data.swift
//  TunePro
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class Data: ObservableObject {
    @AppStorage("currentTheme") var currentTheme = ThemeManager.defaultTheme.name
    @AppStorage("currentSymbol") var currentSymbol = Tuner.Symbol.sharp.rawValue

    static var sharedInstance: Data = {
        Data()
    }()

    private init() {}
}
