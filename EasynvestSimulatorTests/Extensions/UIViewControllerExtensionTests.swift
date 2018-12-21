//
//  UIViewControllerExtensionTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 18/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class UIViewControllerExtensionTests: XCTestCase {
    var viewController: UIViewController!

    override func setUp() {
        super.setUp()
        viewController = UIViewController()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testDismissKeyboard() {
        viewController.dismissKeyboard()
        XCTAssertFalse(viewController.view.isFirstResponder)
    }

    func testKeyboardWillShow() {
        let rect = CGRect(x: 0, y: 568, width: 320, height: 260)

        let notification = NSNotification(name: UIResponder.keyboardWillShowNotification,
                                          object: nil,
                                          userInfo: [UIResponder.keyboardFrameBeginUserInfoKey: rect])
        viewController.keyboardWillShow(notification: notification)

        XCTAssertLessThan(viewController.view.frame.origin.y, 0)
        XCTAssertEqual(viewController.view.frame.origin.y, (rect.height / 2.0) * -1)
    }

    func testKeyboardWillHide() {
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)

        let notification = NSNotification(name: UIResponder.keyboardWillHideNotification,
                                          object: nil,
                                          userInfo: [UIResponder.keyboardFrameBeginUserInfoKey: rect])
        viewController.view.frame.size.height = -130
        viewController.keyboardWillHide(notification: notification)

        XCTAssertEqual(viewController.view.frame.origin.y, 0)
    }
}
