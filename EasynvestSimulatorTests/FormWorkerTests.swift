//
//  FormWorkerTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormWorkerTests: XCTestCase {
    var worker: FormWorker?
    let timeout = 2.0

    override func setUp() {
        worker = FormWorker()
        super.setUp()
    }

    override func tearDown() {
        worker = nil
        super.tearDown()
    }

    // MARK: Date
    func testSimulationWithEmptyMaturityDate() {
        let expectation = XCTestExpectation(description: "Testando simulação com data vazia")

        let request = Form.Request(investedAmount: "1000.0", rate: "100", maturityDate: "")
        worker?.simulate(with: request, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidMaturityDate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    func testSimulationWithMaturityDateWithWrongFormat() {
        let expectation = XCTestExpectation(description: "Testando simulação com data em formato incorreto")

        let request = Form.Request(investedAmount: "1000.0", rate: "100", maturityDate: "12122019")
        worker?.simulate(with: request, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidMaturityDate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    func testSimulationWithInvalidMaturityDate() {
        let expectation = XCTestExpectation(description: "Testando simulação com data invalida")

        let request = Form.Request(investedAmount: "1000", rate: "100", maturityDate: "15/12/1020")
        worker?.simulate(with: request, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, ConsoleMessages.kGenericMessage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    // MARK: Invested Amount
    func testSimulationWithEmptyInvestedAmount() {
        let expectation = XCTestExpectation(description: "Testando simulação com investimento inicial vazio")

        let request = Form.Request(investedAmount: "", rate: "100", maturityDate: "15/12/2020")
        worker?.simulate(with: request, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidInvestedAmount)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    // MARK: Rate
    func testSimulationWithEmptyRate() {
        let expectation = XCTestExpectation(description: "Testando simulação com taxa do CDI vazia")

        let request = Form.Request(investedAmount: "1000.0", rate: "", maturityDate: "15/12/2020")
        worker?.simulate(with: request, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidRate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    // MARK: Correct request data and response
    func testSimulationWithCorrectData() {
        let expectation = XCTestExpectation(description: "Testando requisição com dados corretos")

        let request = Form.Request(investedAmount: "1005.0", rate: "100", maturityDate: "15/12/2020")
        worker?.simulate(with: request, success: { (response) in
            XCTAssertNotNil(response, "Algo ocorreu e a resposta está vazia!")
            let responseInvestedAmount = "\(Int(response.investmentParameter.rate))"

            XCTAssertEqual(responseInvestedAmount, request.rate!)
            expectation.fulfill()
        }, fail: { _ in
            assertionFailure("Não devia estar aqui...")
        })
        wait(for: [expectation], timeout: timeout)
    }
//    func testStringExtension() {
//        assert("R$ 1.005,00".sanitizeCurrency == "1005.0")
//    }
}
