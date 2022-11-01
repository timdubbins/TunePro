//
//  Data.swift
//  TunePro
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class DataController: ObservableObject {
    @AppStorage("currentTheme") var currentTheme = ThemeManager.defaultTheme.nameColor
    @AppStorage("currentSymbol") var currentSymbol = Tuner.Symbol.sharp.rawValue
    @AppStorage("visualizerIsShowing") var visualizerIsShowing = true
    @AppStorage("isFirstAppRun") var isFirstAppRun = true
    @AppStorage("appRunCount") var appRunCount = 0

    static var sharedInstance: DataController = {
        DataController()
    }()

    private init() {
        appRunCount += 1
    }
}
