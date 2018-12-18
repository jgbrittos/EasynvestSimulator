//
//  StringExtensionTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class StringExtensionTests: XCTestCase {
    func testStringCurrencyFormatting() {
        let currencyString = "1".currencyInputFormatting()
        XCTAssertEqual(currencyString.count, "R$ 0,01".count)
    }
}
