//
//  ThemeManager.swift
//  TunePro
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class ThemeManager: ObservableObject {
    private let data = DataController.sharedInstance

    static var sharedInstance: ThemeManager = {
        ThemeManager()
    }()

    @Published var theme = ThemeManager.defaultTheme {
        didSet {
            data.currentTheme = theme.nameColor
        }
    }

    private init() {
        if data.currentTheme == ThemeManager.defaultTheme.nameColor {
            theme = ThemeManager.defaultTheme
        } else {
            theme = ThemeManager.retroTheme
        }
    }

    func swapTheme() {
        if theme.nameColor == ThemeManager.defaultTheme.nameColor {
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
        var nameColor: String
        var accentColor: Color
        var backgroundColor: Color
        var sharpColor: Color
        var flatColor: Color
        var tunedColor: Color
        var visualizerColor: Color
        var faceColor: Color
    }
}

extension ThemeManager {
    static let defaultTheme = Theme(
        nameColor: "Default",
        accentColor: Color.white,
        backgroundColor: Color.black,
        sharpColor: Color.yellow,
        flatColor: Color.red,
        tunedColor: Color.green,
        visualizerColor: Color.pink,
        faceColor: Color(.systemGray6)
    )

    static let retroTheme = Theme(
        nameColor: "Retro",
        accentColor: Color.black,
        backgroundColor: Color("Pitch"),
        sharpColor: Color("Babouche"),
        flatColor: Color("Charlotte"),
        tunedColor: Color("Emerald"),
        visualizerColor: Color("Wevet"),
        faceColor: Color("Tar")
    )
}
