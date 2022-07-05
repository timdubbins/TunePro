//
//  TuningForkShape.swift
//  Tuner
//
//  Created by Timothy Dubbins on 03/07/2022.
//

import SwiftUI

struct TuningForkShape: Shape {
    // swiftlint:disable function_body_length
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height

        var path = Path()

        path.move(to: CGPoint(x: 0.73633*width, y: 0.00146*height))
        path.addCurve(
            to: CGPoint(x: 0.76563*width, y: 0.00146*height),
            control1: CGPoint(x: 0.74473*width, y: -0.00035*height),
            control2: CGPoint(x: 0.75758*width, y: -0.00098*height))
        path.addCurve(
            to: CGPoint(x: 0.79205*width, y: 0.06055*height),
            control1: CGPoint(x: 0.78934*width, y: 0.01035*height),
            control2: CGPoint(x: 0.80102*width, y: 0.03725*height))
        path.addCurve(
            to: CGPoint(x: 0.74023*width, y: 0.11914*height),
            control1: CGPoint(x: 0.78539*width, y: 0.07789*height),
            control2: CGPoint(x: 0.75441*width, y: 0.10496*height))
        path.addCurve(
            to: CGPoint(x: 0.53125*width, y: 0.32813*height),
            control1: CGPoint(x: 0.74023*width, y: 0.11914*height),
            control2: CGPoint(x: 0.53125*width, y: 0.32813*height))
        path.addCurve(
            to: CGPoint(x: 0.45898*width, y: 0.43945*height),
            control1: CGPoint(x: 0.49936*width, y: 0.36002*height),
            control2: CGPoint(x: 0.45906*width, y: 0.39016*height))
        path.addCurve(
            to: CGPoint(x: 0.45898*width, y: 0.44727*height),
            control1: CGPoint(x: 0.45898*width, y: 0.43945*height),
            control2: CGPoint(x: 0.45898*width, y: 0.44727*height))
        path.addCurve(
            to: CGPoint(x: 0.55469*width, y: 0.54102*height),
            control1: CGPoint(x: 0.45959*width, y: 0.49621*height),
            control2: CGPoint(x: 0.50613*width, y: 0.54078*height))
        path.addCurve(
            to: CGPoint(x: 0.56445*width, y: 0.54102*height),
            control1: CGPoint(x: 0.55469*width, y: 0.54102*height),
            control2: CGPoint(x: 0.56445*width, y: 0.54102*height))
        path.addCurve(
            to: CGPoint(x: 0.66602*width, y: 0.47461*height),
            control1: CGPoint(x: 0.60826*width, y: 0.54049*height),
            control2: CGPoint(x: 0.63771*width, y: 0.50291*height))
        path.addCurve(
            to: CGPoint(x: 0.85547*width, y: 0.28516*height),
            control1: CGPoint(x: 0.66602*width, y: 0.47461*height),
            control2: CGPoint(x: 0.85547*width, y: 0.28516*height))
        path.addCurve(
            to: CGPoint(x: 0.90625*width, y: 0.23438*height),
            control1: CGPoint(x: 0.85547*width, y: 0.28516*height),
            control2: CGPoint(x: 0.90625*width, y: 0.23438*height))
        path.addCurve(
            to: CGPoint(x: 0.9668*width, y: 0.20641*height),
            control1: CGPoint(x: 0.92437*width, y: 0.21625*height),
            control2: CGPoint(x: 0.93852*width, y: 0.19986*height))
        path.addCurve(
            to: CGPoint(x: 0.98959*width, y: 0.28125*height),
            control1: CGPoint(x: 1.00051*width, y: 0.2142*height),
            control2: CGPoint(x: 1.01041*width, y: 0.2559*height))
        path.addCurve(
            to: CGPoint(x: 0.92578*width, y: 0.3457*height),
            control1: CGPoint(x: 0.98959*width, y: 0.28125*height),
            control2: CGPoint(x: 0.92578*width, y: 0.3457*height))
        path.addCurve(
            to: CGPoint(x: 0.80078*width, y: 0.4707*height),
            control1: CGPoint(x: 0.92578*width, y: 0.3457*height),
            control2: CGPoint(x: 0.80078*width, y: 0.4707*height))
        path.addCurve(
            to: CGPoint(x: 0.72461*width, y: 0.54688*height),
            control1: CGPoint(x: 0.80078*width, y: 0.4707*height),
            control2: CGPoint(x: 0.72461*width, y: 0.54688*height))
        path.addCurve(
            to: CGPoint(x: 0.60547*width, y: 0.62717*height),
            control1: CGPoint(x: 0.6857*width, y: 0.58578*height),
            control2: CGPoint(x: 0.66111*width, y: 0.61318*height))
        path.addCurve(
            to: CGPoint(x: 0.5*width, y: 0.62416*height),
            control1: CGPoint(x: 0.56965*width, y: 0.63615*height),
            control2: CGPoint(x: 0.53533*width, y: 0.6343*height))
        path.addCurve(
            to: CGPoint(x: 0.47461*width, y: 0.61398*height),
            control1: CGPoint(x: 0.48998*width, y: 0.62129*height),
            control2: CGPoint(x: 0.48391*width, y: 0.61842*height))
        path.addCurve(
            to: CGPoint(x: 0.46176*width, y: 0.6084*height),
            control1: CGPoint(x: 0.47187*width, y: 0.6127*height),
            control2: CGPoint(x: 0.46432*width, y: 0.60842*height))
        path.addCurve(
            to: CGPoint(x: 0.4549*width, y: 0.61176*height),
            control1: CGPoint(x: 0.45883*width, y: 0.6084*height),
            control2: CGPoint(x: 0.45705*width, y: 0.61002*height))
        path.addCurve(
            to: CGPoint(x: 0.38672*width, y: 0.67969*height),
            control1: CGPoint(x: 0.4549*width, y: 0.61176*height),
            control2: CGPoint(x: 0.38672*width, y: 0.67969*height))
        path.addCurve(
            to: CGPoint(x: 0.24805*width, y: 0.81836*height),
            control1: CGPoint(x: 0.38672*width, y: 0.67969*height),
            control2: CGPoint(x: 0.24805*width, y: 0.81836*height))
        path.addCurve(
            to: CGPoint(x: 0.19727*width, y: 0.86914*height),
            control1: CGPoint(x: 0.24805*width, y: 0.81836*height),
            control2: CGPoint(x: 0.19727*width, y: 0.86914*height))
        path.addCurve(
            to: CGPoint(x: 0.17729*width, y: 0.89258*height),
            control1: CGPoint(x: 0.19193*width, y: 0.87447*height),
            control2: CGPoint(x: 0.17918*width, y: 0.88594*height))
        path.addCurve(
            to: CGPoint(x: 0.17729*width, y: 0.91406*height),
            control1: CGPoint(x: 0.17516*width, y: 0.89832*height),
            control2: CGPoint(x: 0.17814*width, y: 0.90383*height))
        path.addCurve(
            to: CGPoint(x: 0.0957*width, y: height),
            control1: CGPoint(x: 0.17506*width, y: 0.95816*height),
            control2: CGPoint(x: 0.14229*width, y: 0.99943*height))
        path.addCurve(
            to: CGPoint(x: 0.08203*width, y: height),
            control1: CGPoint(x: 0.0957*width, y: height),
            control2: CGPoint(x: 0.08203*width, y: height))
        path.addCurve(
            to: CGPoint(x: 0.04883*width, y: 0.99195*height),
            control1: CGPoint(x: 0.07014*width, y: 0.99984*height),
            control2: CGPoint(x: 0.05949*width, y: 0.99729*height))
        path.addCurve(
            to: CGPoint(x: 0.05664*width, y: 0.82824*height),
            control1: CGPoint(x: -0.02014*width, y: 0.9574*height),
            control2: CGPoint(x: -0.01611*width, y: 0.85576*height))
        path.addCurve(
            to: CGPoint(x: 0.0918*width, y: 0.82271*height),
            control1: CGPoint(x: 0.06564*width, y: 0.82484*height),
            control2: CGPoint(x: 0.08223*width, y: 0.82191*height))
        path.addCurve(
            to: CGPoint(x: 0.10742*width, y: 0.82271*height),
            control1: CGPoint(x: 0.09674*width, y: 0.82271*height),
            control2: CGPoint(x: 0.10275*width, y: 0.82449*height))
        path.addCurve(
            to: CGPoint(x: 0.125*width, y: 0.80859*height),
            control1: CGPoint(x: 0.11336*width, y: 0.82105*height),
            control2: CGPoint(x: 0.12053*width, y: 0.81307*height))
        path.addCurve(
            to: CGPoint(x: 0.1582*width, y: 0.77539*height),
            control1: CGPoint(x: 0.125*width, y: 0.80859*height),
            control2: CGPoint(x: 0.1582*width, y: 0.77539*height))
        path.addCurve(
            to: CGPoint(x: 0.30469*width, y: 0.62891*height),
            control1: CGPoint(x: 0.1582*width, y: 0.77539*height),
            control2: CGPoint(x: 0.30469*width, y: 0.62891*height))
        path.addCurve(
            to: CGPoint(x: 0.36719*width, y: 0.56641*height),
            control1: CGPoint(x: 0.30469*width, y: 0.62891*height),
            control2: CGPoint(x: 0.36719*width, y: 0.56641*height))
        path.addCurve(
            to: CGPoint(x: 0.39133*width, y: 0.5402*height),
            control1: CGPoint(x: 0.37154*width, y: 0.56205*height),
            control2: CGPoint(x: 0.39025*width, y: 0.54477*height))
        path.addCurve(
            to: CGPoint(x: 0.38789*width, y: 0.5293*height),
            control1: CGPoint(x: 0.39215*width, y: 0.53672*height),
            control2: CGPoint(x: 0.38936*width, y: 0.53232*height))
        path.addCurve(
            to: CGPoint(x: 0.37811*width, y: 0.50586*height),
            control1: CGPoint(x: 0.38789*width, y: 0.5293*height),
            control2: CGPoint(x: 0.37811*width, y: 0.50586*height))
        path.addCurve(
            to: CGPoint(x: 0.36719*width, y: 0.4375*height),
            control1: CGPoint(x: 0.37016*width, y: 0.48402*height),
            control2: CGPoint(x: 0.36707*width, y: 0.46064*height))
        path.addCurve(
            to: CGPoint(x: 0.41301*width, y: 0.31641*height),
            control1: CGPoint(x: 0.3674*width, y: 0.39318*height),
            control2: CGPoint(x: 0.3851*width, y: 0.35031*height))
        path.addCurve(
            to: CGPoint(x: 0.4707*width, y: 0.25781*height),
            control1: CGPoint(x: 0.41301*width, y: 0.31641*height),
            control2: CGPoint(x: 0.4707*width, y: 0.25781*height))
        path.addCurve(
            to: CGPoint(x: 0.62695*width, y: 0.10156*height),
            control1: CGPoint(x: 0.4707*width, y: 0.25781*height),
            control2: CGPoint(x: 0.62695*width, y: 0.10156*height))
        path.addCurve(
            to: CGPoint(x: 0.69531*width, y: 0.0332*height),
            control1: CGPoint(x: 0.62695*width, y: 0.10156*height),
            control2: CGPoint(x: 0.69531*width, y: 0.0332*height))
        path.addCurve(
            to: CGPoint(x: 0.73633*width, y: 0.00146*height),
            control1: CGPoint(x: 0.70781*width, y: 0.0207*height),
            control2: CGPoint(x: 0.719*width, y: 0.00643*height))
        path.closeSubpath()

        return path
    }
}

struct TuningForkShape_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            TuningForkShape()
                .padding()
                .frame(width: geo.size.width, height: geo.size.width)
        }
    }
}
