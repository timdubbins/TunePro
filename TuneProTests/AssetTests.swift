//
//  AssetTests.swift
//  TuneProTests
//
//  Created by Timothy Dubbins on 21/07/2022.
//

import XCTest
@testable import TunePro

class AssetTests: XCTestCase {
  func testColorExists() {
      for color in ThemeManager.colors {
      XCTAssertNotNil(UIColor(named: color), "Failed to load '\(color)' from asset catalog.")
    }
  }

  func testAppIconExists() {
      XCTAssertNotNil(UIImage(named: "AppIcon"), "Failed to load AppIcon from asset catalog")
  }
}
