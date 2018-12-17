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
    let timeout = 3.0

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

        worker?.simulate(with: Seeds.FormWrongRequest.emptyDateRequest, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidMaturityDate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    func testSimulationWithMaturityDateWithWrongFormat() {
        let expectation = XCTestExpectation(description: "Testando simulação com data em formato incorreto")

        worker?.simulate(with: Seeds.FormWrongRequest.wrongDateFormatRequest, success: { _ in
            assertionFailure("Não devia estar aqui...")
        }, fail: { (message) in
            XCTAssertEqual(message, FormMessages.kInvalidMaturityDate)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: timeout)
    }

    func testSimulationWithInvalidMaturityDate() {
        let expectation = XCTestExpectation(description: "Testando simulação com data invalida")

        worker?.simulate(with: Seeds.FormWrongRequest.wrongDateRequest, success: { _ in
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

        worker?.simulate(with: Seeds.FormWrongRequest.emptyInvestedAmountRequest, success: { _ in
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

        worker?.simulate(with: Seeds.FormWrongRequest.emptyRateRequest, success: { _ in
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

        worker?.simulate(with: Seeds.FormRequest.request, success: { (response) in
            XCTAssertEqual(response.investmentParameter.investedAmount, 100.0)
            XCTAssertEqual(response.investmentParameter.yearlyInterestRate, 7.7734)
            XCTAssertEqual(response.investmentParameter.maturityTotalDays, 729)
            XCTAssertEqual(response.investmentParameter.maturityBusinessDays, 515)
            XCTAssertEqual(response.investmentParameter.maturityDate, "2020-12-15T00:00:00")
            XCTAssertEqual(response.investmentParameter.rate, 100)
            XCTAssertEqual(response.investmentParameter.isTaxFree, false)
            XCTAssertEqual(response.grossAmount, 116.53)
            XCTAssertEqual(response.taxesAmount, 2.48)
            XCTAssertEqual(response.netAmount, 114.05)
            XCTAssertEqual(response.grossAmountProfit, 16.53)
            XCTAssertEqual(response.netAmountProfit, 14.05)
            XCTAssertEqual(response.annualGrossRateProfit, 16.53)
            XCTAssertEqual(response.monthlyGrossRateProfit, 0.63)
            XCTAssertEqual(response.dailyGrossRateProfit, 0.000297110353903562)
            XCTAssertEqual(response.taxesRate, 15.0)
            XCTAssertEqual(response.rateProfit, 7.7734)
            XCTAssertEqual(response.annualNetRateProfit, 14.05)
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
