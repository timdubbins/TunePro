//
//  ThemeManager.swift
//  TuneProTests
//
//  Created by Timothy Dubbins on 18/07/2022.
//

import XCTest
@testable import TunePro

class ThemeManagerTests: XCTestCase {
    var sut: ThemeManager!

    override func setUp() {
        sut = ThemeManager.sharedInstance
    }

    override func tearDown() {
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

    func test_ThemeManager_InitialTheme_ShouldBeEqualToCurrentThemeInData() {
        sut = nil
        sut = ThemeManager.sharedInstance
        let name = sut.theme.name
        let data = Data.sharedInstance

        XCTAssertEqual(name, data.currentTheme)
    }

    func test_ThemeManager_AfterSwappingDefaultTheme_ShouldBeRetroTheme() {
        // given
        sut.theme = ThemeManager.defaultTheme

        // when
        sut.swapTheme()

        // then
        XCTAssertEqual(sut.theme, ThemeManager.retroTheme)
    }

    func test_ThemeManager_AfterSwappingRetroTheme_ShouldBeDefaultTheme() {
        // given
        sut.theme = ThemeManager.retroTheme

        // when
        sut.swapTheme()

        // then
        XCTAssertEqual(sut.theme, ThemeManager.defaultTheme)
    }

    func test_ThemeManager_SettingThemeToDefaultTheme_ShouldSetCurrentThemeInDataToDefaultTheme() {
        // given
        let data = Data.sharedInstance

        // when
        sut.theme = ThemeManager.defaultTheme

        // then
        XCTAssertEqual(data.currentTheme, sut.theme.name)
    }

    func test_ThemeManager_SettingThemeToRetroTheme_ShouldSetCurrentThemeInDataToRetroTheme() {
        // given
        let data = Data.sharedInstance

        // when
        sut.theme = ThemeManager.retroTheme

        // then
        XCTAssertEqual(data.currentTheme, sut.theme.name)
    }

}
