//
//  Data.swift
//  Tuner
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class Data: ObservableObject {
    @AppStorage("currentTheme") var currentTheme = ThemeManager.defaultTheme.name

    @AppStorage("currentSymbol") var currentSymbol = Tuner.Symbol.sharp.rawValue
}
