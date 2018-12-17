//
//  FormInteractorTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormInteractorTests: XCTestCase {
    var interactor: FormInteractor!

    override func setUp() {
        super.setUp()
        interactor = FormInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSimulateSuccess() {
        let presenter = FormPresenterSpy()
        interactor.presenter = presenter
        let worker = FormWorkerSpy()
        interactor.worker = worker

        let request = Form.Request(investedAmount: "100.0", rate: "100", maturityDate: "15/12/2020")

        interactor.simulateInvestment(with: request)

        assert(worker.simulate)
        assert(presenter.presentDetailScreen)
    }

    class FormWorkerSpy: FormWorker {
        // MARK: Method call expectations

        var simulate = false

        // MARK: Spied methods

        override func simulate(with request: Form.Request,
                               success: @escaping (Form.Response) -> Void,
                               fail: @escaping (String) -> Void) {
            simulate = true

            let response = Form.Response(investmentParameter:
                Form.ResponseInvestmentParameter(investedAmount: 100,
                                                 yearlyInterestRate: 7.7734,
                                                 maturityTotalDays: 729,
                                                 maturityBusinessDays: 515,
                                                 maturityDate: "2020-12-15T00:00:00",
                                                 rate: 100,
                                                 isTaxFree: false),
                                         grossAmount: 116.53,
                                         taxesAmount: 2.48,
                                         netAmount: 114.05,
                                         grossAmountProfit: 16.53,
                                         netAmountProfit: 14.05,
                                         annualGrossRateProfit: 16.53,
                                         monthlyGrossRateProfit: 0.63,
                                         dailyGrossRateProfit: 0.000297110353903562,
                                         taxesRate: 15,
                                         rateProfit: 7.7734,
                                         annualNetRateProfit: 14.05)
            success(response)
        }
    }

    class FormPresenterSpy: FormPresentationLogic {
        // MARK: Method call expectations

        var presentDetailScreen = false

        // MARK: Spied methods

        func presentSimulation(response: Form.Response) {
            presentDetailScreen = true
        }

        func presentErrorAlert(message: String) {
        }
    }
}
