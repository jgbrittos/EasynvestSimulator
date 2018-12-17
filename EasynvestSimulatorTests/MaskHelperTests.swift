//
//  MaskTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class MaskHelperTests: XCTestCase {
    func testDateMaskInEdition() {
        let textfield = UITextField()
        textfield.text = "12/"

        let range = NSRange(location: 3, length: 0)

        let result = Mask.date(textfield, shouldChangeCharactersIn: range, replacementString: "1")
        XCTAssertFalse(result)
    }

    func testDateMaskFinished() {
        let textfield = UITextField()
        textfield.text = "12/12/2020"

        let range = NSRange(location: 10, length: 0)

        let result = Mask.date(textfield, shouldChangeCharactersIn: range, replacementString: "1")
        XCTAssertFalse(result)
    }
}
