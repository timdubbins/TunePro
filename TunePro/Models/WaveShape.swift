//
//  WaveShape.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import SwiftUI

struct WaveShape: Shape {
    /// The amplitude of the  wave, in range [0,1].
    var amplitude: CGFloat
    /// The frequency of the wave.
    var frequency: CGFloat
    /// The phase shift applied to the wave.
    var phase: CGFloat

    init(_ amplitude: Float, _ frequency: Float, phase: Float) {
        self.amplitude = CGFloat(amplitude)
        self.frequency = CGFloat(frequency)
        self.phase = CGFloat(phase)
    }

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: center.y))

        let wavelength = rect.width / frequency

        // Stride through the horizontal points of the wave. A larger stride reduces
        // the number of iterations but also reduces the smoothness of the path.
        for x in stride(from: 0, through: rect.width, by: 2) {
            // The current x position relative to the wavelength.
            let relativeX = x / wavelength

            // The sine value of that position, including the phase shift, in range [-1,1].
            let sine = sin(2 * .pi * relativeX + phase)

            // The normalized distance from x to center.x, in range [-1,1].
            let normalDistance = (x - center.x) / center.x

            // The quadratic expression evaluated at that distance, in range [0,1].
            let quadraticScaleFactor = parabola(normalDistance)

            // Scale center.y by our normalized values and then translate to center.y.
            let y = quadraticScaleFactor * amplitude * sine * center.y + center.y

            path.addLine(to: CGPoint(x: x, y: y))
        }

        return Path(path.cgPath)
    }

    // Parabola with vertex (0, 1) and roots x == ± 1.
    private func parabola(_ x: CGFloat) -> CGFloat { 1 - x * x }
}

/// Extend the wave description to conform to the Animatable type to
/// simplify creation of custom shapes using the wave.
extension WaveShape: Animatable {
    // Merge the interpolated values into a single type using
    // a composition of pairs. Animatable pair acts as a single
    // interpolatable value given two interpolatable inputs.
    typealias AnimatableData = AnimatablePair<
        CGFloat, AnimatablePair<CGFloat, CGFloat>>

    var animatableData: AnimatableData {
        get {
            AnimatablePair(
                phase, AnimatablePair(amplitude, frequency))
        }
        set {
            self.phase = newValue.first
            self.amplitude = newValue.second.first
            self.frequency = newValue.second.second
        }
    }
}
