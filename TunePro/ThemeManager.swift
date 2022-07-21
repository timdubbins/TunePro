//
//  ThemeManager.swift
//  TunePro
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class ThemeManager: ObservableObject {
    private let data = Data.sharedInstance

    static var sharedInstance: ThemeManager = {
        ThemeManager()
    }()

    @Published var theme = ThemeManager.defaultTheme {
        didSet {
            data.currentTheme = theme.name
        }
    }

    private init() {
        if data.currentTheme == ThemeManager.defaultTheme.name {
            theme = ThemeManager.defaultTheme
        } else {
            theme = ThemeManager.retroTheme
        }
    }

    func swapTheme() {
        if theme.name == ThemeManager.defaultTheme.name {
            theme = ThemeManager.retroTheme
        } else {
            theme = ThemeManager.defaultTheme
        }
    }

    static let colors = [
        "Pitch",
        "Babouche",
        "Charlotte",
        "Emerald",
        "Tar",
        "Wevet"
    ]

    struct Theme: Equatable {
        var name: String
        var accent: Color
        var background: Color
        var sharp: Color
        var flat: Color
        var tuned: Color
        var vizualiser: Color
        var face: Color
    }
}

extension ThemeManager {
    static let defaultTheme = Theme(
        name: "Default",
        accent: Color.white,
        background: Color.black,
        sharp: Color.yellow,
        flat: Color.red,
        tuned: Color.green,
        vizualiser: Color.pink,
        face: Color(.systemGray6)
    )

    static let retroTheme = Theme(
        name: "Retro",
        accent: Color.black,
        background: Color("Pitch"),
        sharp: Color("Babouche"),
        flat: Color("Charlotte"),
        tuned: Color("Emerald"),
        vizualiser: Color("Wevet"),
        face: Color("Tar")
    )
}
