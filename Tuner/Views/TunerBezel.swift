//
//  TunerBezel.swift
//  GuitarKit
//
//  Created by Timothy Dubbins on 16/11/2021.
//

import SwiftUI

struct TunerBezel: View {
    @StateObject var vm = ViewModel()
    
    var body: some View {
            ZStack {            
            WedgeShape(wedge: Wedge.topWedge)
                .foregroundColor(vm.state == .tuned ? Color.green : Color.white)
            
            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                    .stroke(Color.white)
                    .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
            
            ForEach(0..<10) { wedgeNumber in
                WedgeShape(wedge: Wedge.wedge)
                .foregroundColor(pitch.state == .tuned ? Color.green : getColor(wedgeNumber, pitch))
                .rotationEffect(.degrees(Double(wedgeNumber) * 31.5))
            }
            .rotationEffect(.degrees(296.8))
        }
    }
}

struct TunerBezel_Previews: PreviewProvider {
    static var previews: some View {
        TunerBezel(Tuner.Pitch.preview).background(Color.black)
    }
}

struct WedgeShape: Shape {
    let wedge: Wedge
    
    func path(in rect: CGRect) -> Path {
        let points = WedgeGeometry(wedge, in: rect)
        let midLeading = CGPoint.midpoint(
            points[.bottomLeading], points[.topLeading])
        let midTrailing = CGPoint.midpoint(
            points[.topTrailing], points[.bottomTrailing])
        
        var path = Path()
        
        path.addArc(
            center: points.center,
            radius: points.innerRadius,
            startAngle: .radians(wedge.start),
            endAngle: .radians(wedge.end),
            clockwise: false)
        
        path.addQuadCurve(
            to: points[.bottomTrailing],
            control: midTrailing.rotate(around: points.center, angle: 0.05))
        
        path.addArc(
            center: points.center,
            radius: points.outerRadius,
            startAngle: .radians(wedge.end),
            endAngle: .radians(wedge.start),
            clockwise: true)
        
        path.addQuadCurve(
            to: points[.topLeading],
            control: midLeading.rotate(around: points.center, angle: -0.05))
        
        return path
    }
}

/// A single wedge.
struct Wedge {
    /// The top wedge, centered at the 12 o'clock position of the bezel.
    static let topWedge = Wedge(start: .pi * 7/5, end: .pi * 8/5)
    /// The wedge that is repeated around the bezel.
    static let wedge = Wedge(start: 0, end: 0.4)
    
    var start: Double = 0.0
    var end: Double = 0.0
}

/// Helper type for creating view-space points within a wedge.
private struct WedgeGeometry {
    let wedge: Wedge
    let center: CGPoint
    let innerRadius: CGFloat
    let outerRadius: CGFloat
    
    init(_ wedge: Wedge, in rect: CGRect) {
        self.wedge = wedge
        center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        innerRadius = radius - 17
        outerRadius = radius
    }
    
    /// Returns the view location of the point in the wedge at unit-
    /// space location `unitPoint`, where the X axis of `p` moves around the
    /// wedge arc and the Y axis moves out from the inner to outer radius.
    subscript(unitPoint: UnitPoint) -> CGPoint {
        let radius = lerp(values: (from: innerRadius, to: outerRadius), by: unitPoint.y)
        let angle = lerp(values: (from: wedge.start, to: wedge.end), by: Double(unitPoint.x))
        
        return CGPoint(
            x: center.x + CGFloat(cos(angle)) * radius,
            y: center.y + CGFloat(sin(angle)) * radius)
    }
    
    /// Linearly interpolate between two values `from` and `to`  by the fraction `amount`.
    private func lerp<T: BinaryFloatingPoint>(values: (from: T, to: T), by amount: T) -> T {
        return values.from + (values.to - values.from) * amount
    }
}

/// Returns the color for the given wedge and pitch.
private func getColor(_ wedgeNumber: Int, _ pitch: Tuner.Pitch) -> Color {
    let state = pitch.state
    let distance = pitch.distance
    let sharpColor = Color.yellow
    let flatColor = Color.red
    let defaultColor = Color.clear
    
    switch wedgeNumber {
    case 0:
        return state == .sharp ? sharpColor : defaultColor
    case 1:
        return state == .sharp && distance > 0.18 ? sharpColor : defaultColor
    case 2:
        return state == .sharp && distance > 0.26 ? sharpColor : defaultColor
    case 3:
        return state == .sharp && distance > 0.34 ? sharpColor : defaultColor
    case 4:
        return state == .sharp && distance > 0.42 ? sharpColor : defaultColor
    case 5 :
        return state == .flat && distance < 0.58 ? flatColor : defaultColor
    case 6:
        return state == .flat && distance < 0.66 ? flatColor : defaultColor
    case 7:
        return state == .flat && distance < 0.74 ? flatColor : defaultColor
    case 8:
        return state == .flat && distance < 0.82 ? flatColor : defaultColor
    case 9:
        return state == .flat ? flatColor : defaultColor
    default:
        return defaultColor
    }
}
