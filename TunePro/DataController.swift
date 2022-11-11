//
//  Data.swift
//  TunePro
//
//  Created by Timothy Dubbins on 06/07/2022.
//

import SwiftUI

class DataController: ObservableObject {
    @AppStorage("currentTheme") var currentTheme = Theme.original.name
    @AppStorage("currentSymbol") var currentSymbol = Tuner.Symbol.sharp.rawValue
    @AppStorage("visualizerIsShowing") var visualizerIsShowing = true
    @AppStorage("isFirstAppRun") var isFirstAppRun = true
    @AppStorage("appRunCount") var appRunCount = 0

    /// The theme that is used throughout the app.
    @Published var theme = Theme.original {
        didSet {
            // store in user defaults
            currentTheme = theme.name
        }
    }

    static var sharedInstance: DataController = {
        let data = DataController()
        // retrieve from user defaults
        data.theme = Theme.with(name: data.currentTheme)
        
        return data
    }()

    private init() {
        appRunCount += 1
    }

    /// Sets theme by cycling through available themes.
    func nextTheme() {
        theme = theme.next()
    }
}

struct Theme: Equatable {
    /// An array of all themes used in the app.
    private static let themes: [Theme] = [Theme.original, Theme.retro]

    var name: String
    var accentColor: Color
    var backgroundColor: Color
    var sharpColor: Color
    var flatColor: Color
    var tunedColor: Color
    var visualizerColor: Color
    var faceColor: Color

    /// Gets the next theme in the themes array,  Returns the first
    /// element if the current theme is the last element.
    fileprivate func next() -> Theme {
        Theme.themes.item(afterWithWrapAround: self) ?? Theme.original
    }

    /// Gets the theme matching the given name. Provides
    /// a valid theme if there are no matches.
    fileprivate static func with(name: String) -> Theme {
        Theme.themes.first(where: { theme in
            theme.name == name
        }) ?? Theme.original
    }
}

extension Theme {
    // define new themes here

    fileprivate static let original = Theme(
        name: "Default",
        accentColor: Color.white,
        backgroundColor: Color.black,
        sharpColor: Color.yellow,
        flatColor: Color.red,
        tunedColor: Color.green,
        visualizerColor: Color.pink,
        faceColor: Color(.systemGray6)
    )

    fileprivate static let retro = Theme(
        name: "Retro",
        accentColor: Color.black,
        backgroundColor: Color("Pitch"),
        sharpColor: Color("Babouche"),
        flatColor: Color("Charlotte"),
        tunedColor: Color("Emerald"),
        visualizerColor: Color("Wevet"),
        faceColor: Color("Tar")
    )
}
