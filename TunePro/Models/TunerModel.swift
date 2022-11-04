//
//  TunerModel.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import Foundation

class Tuner {
    /// Symbols used for sharp or flat notes.
    enum Symbol: String, CaseIterable {
        case sharp = "♯"
        case flat = "♭"
    }

    /// The state of the tuner.
    enum State {
        case tuned
        case sharp
        case flat
        case clear
    }

    /// The data model for the tuner face.
    struct Face {
        /// The frequency of the input signal.
        var frequency: String = "261.6"
        /// The note nearest to the frequency.
        var note: String = "C"
        /// The symbol to be displayed.
        var symbol: String = " "
        /// The current octave.
        var octave: String = "4"
        /// Whether or not the symbol has been changed.
        var showingSymbol: Bool = false
    }

    /// The data model for the tuner bezel.
    struct Bezel {
        /// The current state of the pitch.
        var state: Tuner.State = .tuned
        /// The distance of the pitch from the last note, in range [0, 1]
        var distance: Double = 0.0
    }

    /// The data model for the tuner visualizer.
    struct Visualizer {
        let phase: [Float] = [0, 2 * .pi / 3, 4 * .pi / 3]

        /// The clamped amplitude, in range [0,1]
        var amplitude: Float = 0.0
        /// A raw frequency value.
        var frequency: Float = 0.0
    }

    /// Array of frequencies of notes in range [B2, C4].
    let frequencies: [Float] = [
        123.47, 130.81, 138.59, 146.83, 155.56, 164.81, 174.61,
        185.0, 196.00, 207.65, 220.0, 233.08, 246.94, 261.63
    ]

    /// Array of natural notes to be used when displaying sharp symbols.
    let notesWithSharps = [
        "B", "C", "C", "D", "D", "E", "F", "F", "G", "G", "A", "A", "B", "C"
    ]

    /// Array of natural notes to be used when displaying flat symbols.
    let notesWithFlats = [
        "B", "C", "D", "D", "E", "E", "F", "G", "G", "A", "A", "B", "B", "C"
    ]

    /// The type of symbol currently selected.
    var symbol: Symbol = .sharp
}

/// Example data for testing and generating app screenshots.
extension Tuner {
    struct Example {
        let face: Face
        let bezel: Bezel
        let visualizer: Visualizer

        init(face: Face, bezel: Bezel, visualizer: Visualizer) {
            self.face = face
            self.bezel = bezel
            self.visualizer = visualizer
        }
    }
    
    static let example1 = Example(
        face: Face(frequency: "181.0", note: "F", symbol: "♯", octave: "3", showingSymbol: false),
        bezel: Bezel(state: .flat, distance: 0.6150144338607788),
        visualizer: Visualizer(amplitude: 0.25, frequency: 181)
    )

    static let example2 = Example(
        face: Face(frequency: "316.0", note: "D", symbol: "♯", octave: "4", showingSymbol: false),
        bezel: Bezel(state: .sharp, distance: 0.2637840509414673),
        visualizer: Visualizer(amplitude: 0.25, frequency: 316.0)
    )

    static let example3 = Example(
        face: Face(frequency: "82.0", note: "E", symbol: " ", octave: "2", showingSymbol: false),
        bezel: Bezel(state: .tuned, distance: 0.9124326705932617),
        visualizer: Visualizer(amplitude: 0.15, frequency: 82.0)
    )

    static let example4 = Example(
        face: Face(frequency: "135.0", note: "C", symbol: "♯", octave: "3", showingSymbol: false),
        bezel: Bezel(state: .flat, distance: 0.5385608077049255),
        visualizer: Visualizer(amplitude: 0.25, frequency: 135.0)
    )
}
