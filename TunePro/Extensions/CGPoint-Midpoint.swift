//
//  CGPoint-MidBetween.swift
//  TunePro
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import CoreGraphics

extension CGPoint {
    /// Returns the midpoint between `pointA` and `pointB`.
    static func midpoint(_ pointA: CGPoint, _ pointB: CGPoint) -> CGPoint {
        CGPoint(
            x: (pointA.x + pointB.x) / 2,
            y: (pointA.y + pointB.y) / 2)
    }
}
