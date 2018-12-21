//
//  FormInteractorTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormInteractorTests: XCTestCase {
    var interactor: FormInteractor!
    var presenter: FormPresenterSpy!

    override func setUp() {
        super.setUp()
        interactor = FormInteractor()
        presenter = FormPresenterSpy()
        interactor.presenter = presenter
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimulateSuccess() {
        interactor.worker = FormWorkerSuccessSpy()

        interactor.simulateInvestment(with: Seeds.FormRequest.request)

        XCTAssertEqual(presenter.response.investmentParameter.investedAmount, 100.00)
        XCTAssertEqual(presenter.response.investmentParameter.yearlyInterestRate, 7.7734)
        XCTAssertEqual(presenter.response.investmentParameter.maturityTotalDays, 729)
        XCTAssertEqual(presenter.response.investmentParameter.maturityBusinessDays, 515)
        XCTAssertEqual(presenter.response.investmentParameter.maturityDate, "2020-12-15T00:00:00")
        XCTAssertEqual(presenter.response.investmentParameter.rate, 100)
        XCTAssertEqual(presenter.response.investmentParameter.isTaxFree, false)
        XCTAssertEqual(presenter.response.grossAmount, 116.53)
        XCTAssertEqual(presenter.response.taxesAmount, 2.48)
        XCTAssertEqual(presenter.response.netAmount, 114.05)
        XCTAssertEqual(presenter.response.grossAmountProfit, 16.53)
        XCTAssertEqual(presenter.response.netAmountProfit, 14.05)
        XCTAssertEqual(presenter.response.annualGrossRateProfit, 16.53)
        XCTAssertEqual(presenter.response.monthlyGrossRateProfit, 0.63)
        XCTAssertEqual(presenter.response.dailyGrossRateProfit, 0.000297110353903562)
        XCTAssertEqual(presenter.response.taxesRate, 15.0)
        XCTAssertEqual(presenter.response.rateProfit, 7.7734)
        XCTAssertEqual(presenter.response.annualNetRateProfit, 14.05)
    }

    func testSimulateFail() {
        interactor.worker = FormWorkerFailSpy()

        interactor.simulateInvestment(with: Seeds.FormRequest.request)

        let errorMessage = "MENSAGEM_DE_ERRO"
        XCTAssertEqual(presenter.errorMessage, errorMessage)
    }

    class FormWorkerSuccessSpy: FormWorker {
        override func simulate(with request: Form.Request,
                               success: @escaping (Form.Response) -> Void,
                               fail: @escaping (String) -> Void) {
            success(Seeds.FormResponse.response)
        }
    }

    class FormWorkerFailSpy: FormWorker {
        override func simulate(with request: Form.Request,
                               success: @escaping (Form.Response) -> Void,
                               fail: @escaping (String) -> Void) {
            fail("MENSAGEM_DE_ERRO")
        }
    }

    class FormPresenterSpy: FormPresentationLogic {
        var errorMessage = ""
        var response: Form.Response!

        func presentSimulation(response: Form.Response) {
            self.response = response
        }

        func presentErrorAlert(message: String) {
            self.errorMessage = message
        }
    }
}
