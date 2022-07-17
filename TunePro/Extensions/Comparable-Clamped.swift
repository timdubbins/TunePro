//
//  Comparable-Clamped.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
