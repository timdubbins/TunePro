//
//  UIDevice-IsPad.swift
//  TunePro
//
//  Created by Timothy Dubbins on 04/11/2022.
//

import SwiftUI

extension UIDevice {
    /// Whether or not the current interface is set for iPad.
    static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
}
