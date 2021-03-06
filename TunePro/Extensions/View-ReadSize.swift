//
//  View - ReadSize.swift
//  TunePro
//
//  Original implementation: https://stackoverflow.com/questions/57577462/get-width-of-a-view-using-in-swiftui
//
//  Created by Timothy Dubbins on 05/04/2022.
//

import SwiftUI

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geo.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
