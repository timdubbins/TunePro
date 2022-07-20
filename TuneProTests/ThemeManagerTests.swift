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

    func test_ThemeManager_ThemeName_ShouldBeEqualThemeNameInData() {
        // given
        let name = sut.theme.name
        let data = Data.sharedInstance

        // then
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
