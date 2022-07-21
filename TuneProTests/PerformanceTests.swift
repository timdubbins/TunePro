//
//  PerformanceTests.swift
//  TuneProTests
//
//  Created by Timothy Dubbins on 21/07/2022.
//

import XCTest
@testable import TunePro

class PerformanceTests: XCTestCase {
    func testUpdateTunerPerformance() throws {
        let sut = TunerView.ViewModel()
        var count = 0

        var data = [(Float, Float)]()

        repeat {
            data.append((Float.NormalizedRandom * 1.2, Float.NormalizedRandom))
            count += 1
        } while count < 500

        measure {
            for (x, y) in data {
                sut.updateTuner(x, y)
            }
        }
    }
}
