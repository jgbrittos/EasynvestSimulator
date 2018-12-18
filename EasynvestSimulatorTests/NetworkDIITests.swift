//
//  NetworkDIITests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 17/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator
//TODO: TENTAR FAZER UMA REQUISIÇÃO QUE RETORNE DATA NIL
class NetworkDIITests: XCTestCase, NetworkDependency {
    lazy var networkHandler: JGNetwork = network
    let timeout = 10.0

    override func setUp() {
        super.setUp()
//        networkHandler = CoreDependency().network
    }

    func testCorrectRequest() {
        let expectation = XCTestExpectation(description: "Testando requisição com dados corretos")
        networkHandler.getRequest(for: API.url, with: Seeds.NetworkRequest.params, success: { (response) in
            XCTAssertNotNil(response)
            expectation.fulfill()
        }, failure: { _ in
            assertionFailure("Não devia estar aqui...")
        })

        wait(for: [expectation], timeout: timeout)
    }

    func testIncorrectRequest() {
        let expectation = XCTestExpectation(description: "Testando requisição com dados corretos")
        networkHandler.getRequest(for: API.url, with: Seeds.NetworkRequest.wrongKeyParams, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, failure: { (message) in
            XCTAssertNotNil(message)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: timeout)
    }

    func testIncorrectRequestWithEmptyDate() {
        let expectation = XCTestExpectation(description: "Testando simulação com data vazia")
        networkHandler.getRequest(for: API.url, with: Seeds.NetworkRequest.wrongParams, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, failure: { (message) in
            XCTAssertNotNil(message)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    func testInternalServerErrorWithInvalidDate() {
        let expectation = XCTestExpectation(description: "Testando simulação com data invalida")

        networkHandler.getRequest(for: API.url, with: Seeds.NetworkRequest.internalServerErrorParams, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, failure: { (message) in
            XCTAssertNotNil(message)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }
}
