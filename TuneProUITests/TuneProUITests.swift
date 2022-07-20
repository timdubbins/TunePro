//
//  TuneProUITests.swift
//  TuneProUITests
//
//  Created by Timothy Dubbins on 17/07/2022.
//

import XCTest

class TuneProUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_SwapThemeButtonExists() {
        let button = app.buttons["swapTheme"]

        button.tap()
        XCTAssertTrue(button.exists)
    }

    func test_ToggleSymbolButtonExists() {
        let button = app.buttons["toggleSymbol"].firstMatch

        button.tap()
        XCTAssertTrue(button.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
