//
//  CGPoint-Rotate.swift
//  Tuner
//
//  Created by Timothy Dubbins on 26/06/2022.
//

import CoreGraphics

extension CGPoint {
    /// Returns a point that is rotated around `center` by `angle`.
    func rotate(around center: CGPoint, angle: CGFloat) -> CGPoint {
        let translate = CGAffineTransform(translationX: -center.x, y: -center.y)
        let transform = translate.concatenating(CGAffineTransform(rotationAngle: angle))
        let rotated = applying(transform)
        return rotated.applying(CGAffineTransform(translationX: center.x, y: center.y))
    }
}
