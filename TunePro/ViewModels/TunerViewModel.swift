//
//  TunerViewModel.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import Combine
import Foundation

extension TunerView {
    class ViewModel: ObservableObject {
        // MARK: - Properties

        private let audio: Audio
        private let tuner: Tuner
        private let data: Data

        /// The data needed to update the tuner face.
        @Published var face = Tuner.Face()

        /// The data needed to animate the tuner bezel.
        @Published var bezel = Tuner.Bezel()

        /// The data needed to animate the tuner visualizer.
        @Published var visualizer = Tuner.Visualizer()

        /// Cancellable for the pitch tap.
        private var cancellable: AnyCancellable?

        // MARK: - Methods

        init(data: Data) {
            audio = Audio.sharedInstance
            tuner = Tuner()
            self.data = data

            if data.currentSymbol == Tuner.Symbol.sharp.rawValue {
                tuner.symbol = .sharp
            } else {
                tuner.symbol = .flat
            }

            cancellable = audio.$pitchTapData
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    guard let self = self else { return }

                    self.updateTuner($0.amplitude, $0.frequency)
                }
        }

        func startPitchTap() {
            audio.pitchTap.start()
        }

        func stopPitchTap() {
            audio.pitchTap.stop()
        }

        /// Toggles the symbol between sharp and flat.
        func symbolToggle() {
            guard face.showingSymbol == false else { return }

            if tuner.symbol == .sharp {
                tuner.symbol = .flat
                data.currentSymbol = Tuner.Symbol.flat.rawValue
            } else {
                tuner.symbol = .sharp
                data.currentSymbol = Tuner.Symbol.sharp.rawValue
            }

            stopPitchTap()
            visualizer.amplitude = 0
            bezel.state = .clear
            face.symbol = tuner.symbol.rawValue
            face.showingSymbol = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.startPitchTap()
                self.face.showingSymbol = false
            }
        }

        /// Updates the model with data from the pitch tap.
        private func updateTuner(_ amplitude: Float, _ frequency: Float) {
            // Reduce interference from background noise by setting a lower-bound
            // on amplitude. Without this the tuner can fluctuate randomly.
            guard amplitude > 0.05 else {
                visualizer.amplitude = 0
                return
            }

            let adjustedFrequency = adjustedFrequency(frequency)
            let index = nearestIndex(to: adjustedFrequency)
            let distance = distanceFromLastNote(using: index, adjustedFrequency)
            let octave = Int(log2f(frequency / adjustedFrequency)) + 3

            var notes: [String] {
                if tuner.symbol == .sharp {
                    return tuner.notesWithSharps
                } else {
                    return tuner.notesWithFlats
                }
            }

            face.frequency = String(format: "%.1f", frequency)
            face.note = String(notes[index])
            face.symbol = getSymbol(for: index)
            face.octave = String(octave)
            bezel.distance = distance
            bezel.state = getState(from: distance)
            visualizer.amplitude = adjustedAmplitude(amplitude)
            visualizer.frequency = frequency
        }

        private func adjustedAmplitude(_ amplitude: Float) -> Float {
            if audio.headsetMicConnected {
                return 0.2 * amplitude.clamped(to: 0...1)
            } else {
                return amplitude.clamped(to: 0...1)
            }
        }

        /// Scale the input frequency so that it lies within the bounds of the array `frequencies`.
        private func adjustedFrequency(_ frequency: Float) -> Float {
            var frequency = frequency
            let lastIndex = tuner.frequencies.count - 1

            while frequency > tuner.frequencies[lastIndex] { frequency /= 2 }
            while frequency < tuner.frequencies[0] { frequency *= 2 }

            return frequency
        }

        /// Gives the index of the value in the array `frequencies` that is closest to the input `frequency`.
        private func nearestIndex(to frequency: Float) -> Int {
            var index = 0
            var minDistance: Float = 10_000.0

            for possibleIndex in 0 ..< tuner.frequencies.count {
                let distance = fabsf(tuner.frequencies[possibleIndex] - frequency)

                guard distance < minDistance else { return index }

                index = possibleIndex
                minDistance = distance
            }

            return index
        }

        /// Finds the correct symbol to display. If the note is not sharp or flat a single space is
        /// used to maintain the correct view spacing.
        private func getSymbol(for index: Int) -> String {
            // This array contains the indices of notes that are sharp / flat.
            guard [2, 4, 7, 9, 11].contains(index) else { return " " }
            return tuner.symbol.rawValue
        }

        /// Expresses the distance from the last note to the frequency as a double in range [0, 1].
        private func distanceFromLastNote(using index: Int, _ frequency: Float) -> Double {
            // Create temporary (mutable) vars:
            var index = index
            var frequency = frequency

            // Frequencies at the start and end of the array are moved up or down an
            // octave, respectively, so that they are 'sandwiched' between other values.
            if index == 0 { index = 12; frequency *= 2 }
            if index == 13 { index = 1; frequency /= 2 }

            // Ensure distance is calculated from the previous element to frequency.
            if frequency < tuner.frequencies[index] { index -= 1 }

            let distance =  frequency - tuner.frequencies[index]
            let sizeOfInterval = tuner.frequencies[index + 1] - tuner.frequencies[index]

            return Double(distance / sizeOfInterval)
        }

        /// Gets the tuner state (tuned, flat or sharp) using the distance from the preceding note.
        private func getState(from distance: Double) -> Tuner.State {
            // This interval is the error-margin for being 'tuned'.
            // The pitch -> tuned as distance -> zero.
            if distance > 0.9 || distance < 0.1 {
                return .tuned
            // The pitch gets sharper as distance increases
            // over range (0, 0.5).
            } else if distance < 0.5 {
                return .sharp
            // When distance > 0.5 the tuner displays the
            // next note up, thus the pitch gets flatter as
            // distance increases over range (0.5, 1).
            } else {
                return .flat
            }
        }
    }
}
