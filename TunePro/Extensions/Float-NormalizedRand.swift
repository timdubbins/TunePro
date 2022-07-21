//
//  Float-NormalizedRand.swift
//  TunePro
//
//  Created by Timothy Dubbins on 21/07/2022.
//

import Foundation

extension Float {
    /// Returns a random float in range [0, 1]
    static var NormalizedRandom: Float {
        Float(arc4random()) / Float(0xFFFFFFFF)
    }
}
