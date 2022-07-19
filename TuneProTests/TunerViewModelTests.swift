//
//  TunerViewModelTests.swift
//  TuneProTests
//
//  Created by Timothy Dubbins on 19/07/2022.
//

import XCTest
@testable import TunePro

class TunerViewModelTests: XCTestCase {
    var sut: TunerView.ViewModel!

    override func setUpWithError() throws {
        sut = TunerView.ViewModel()
        sut.tuner.symbol = .sharp
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_TunerViewModel_SymbolToggledFromSharp_ShouldBeFlatSymbol() {
        // given
        sut.tuner.symbol = .sharp

        // when
        sut.symbolToggle()

        // then
        XCTAssertEqual(sut.tuner.symbol, .flat)
    }

    func test_TunerViewModel_SymbolToggledFromFlat_ShouldBeSharpSymbol() {
        // given
        sut.tuner.symbol = .flat

        // when
        sut.symbolToggle()

        // then
        XCTAssertEqual(sut.tuner.symbol, .sharp)
    }

    func test_TunerViewModel_SymbolToggledFromSharp_ShouldSetCurrentSymbolInDataToFlat() {
        // given
        sut.tuner.symbol = .sharp

        // when
        sut.symbolToggle()

        // then
        XCTAssertEqual(sut.data.currentSymbol, Tuner.Symbol.flat.rawValue)
    }

    func test_TunerViewModel_SymbolToggledFromFlat_ShouldSetCurrentSymbolInDataToSharp() {
        // given
        sut.tuner.symbol = .flat

        // when
        sut.symbolToggle()

        // then
        XCTAssertEqual(sut.data.currentSymbol, Tuner.Symbol.sharp.rawValue)
    }

    func test_TunerViewModel_SymbolToggledFromFlatWhileShowingSymbol_ShouldBeFlat() {
        // given
        sut.tuner.symbol = .flat
        sut.face.showingSymbol = true

        // when
        sut.symbolToggle()

        // then
        XCTAssertEqual(sut.tuner.symbol, .flat)
    }

    func test_TunerViewModel_NoteOfFrequency1000Hz_ShouldBeNoteB() {
        // given
        let frequency: Float  = 1000
        let amplitude: Float = 1
        sut.tuner.symbol = .sharp

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.face.note, "B")
    }

    func test_TunerViewModel_SymbolForFrequencyOneThreeEightHz_ShouldBeSharpSymbol() {
        // given
        let frequency: Float = 138
        let amplitude: Float = 1
        sut.tuner.symbol = .flat

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.face.symbol, Tuner.Symbol.flat.rawValue)
    }

    func test_TunerViewModel_OctaveForFrequency250Hz_ShouldBeThree() {
        // given
        let frequency: Float = 250
        let amplitude: Float = 1

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.face.octave, "3")
    }

    func test_TunerViewModel_DistanceForFrequency10Hz_ShouldBeZeroPointFourEight() {
        // given
        let frequency: Float  = 10
        let amplitude: Float = 1

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.bezel.distance, 0.48, accuracy: 0.000001)
    }

    func test_TunerViewModel_StateForFrequency150Hz_ShouldBeFlat() {
        // given
        let frequency: Float  = 150
        let amplitude: Float = 1

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.bezel.state, .sharp)
    }

    func test_TunerViewModel_AdjustedAmplitudeFor2Decibels_ShouldBe1Decibel() {
        // given
        let frequency: Float = 1
        let amplitude: Float = 2

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.visualizer.amplitude, 1)

    }

    func test_TunerViewModel_AdjustedAmplitudeForNegative1Decibels_ShouldBeZeroDecibels() {
        // given
        let frequency: Float = 1
        let amplitude: Float = -1

        // when
        sut.updateTuner(amplitude, frequency)

        // then
        XCTAssertEqual(sut.visualizer.amplitude, 0)
    }
}
