//
//  FormPresenterTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormPresenterTests: XCTestCase {
    var presenter: FormPresenter!

    override func setUp() {
        super.setUp()
        presenter = FormPresenter()
    }

    func testDisplaySimulationSuccessful() {
        let viewController = FormViewControllerSpy()
        presenter.viewController = viewController

        presenter.presentSimulation(response: Seeds.FormResponse.response)

        XCTAssertEqual(viewController.viewModel.investedAmount.sanitizeCurrency, "100.00")
        XCTAssertEqual(viewController.viewModel.grossAmount.sanitizeCurrency, "116.53")
        XCTAssertEqual(viewController.viewModel.grossAmountProfit.sanitizeCurrency, "16.53")
        XCTAssertEqual(viewController.viewModel.taxesAmountAndRate.sanitizeCurrency, "2.48(15%)")
        XCTAssertEqual(viewController.viewModel.netAmount.sanitizeCurrency, "114.05")
        XCTAssertEqual(viewController.viewModel.maturityDate, "15/12/2020")
        XCTAssertEqual(viewController.viewModel.maturityTotalDays, 729)
        XCTAssertEqual(viewController.viewModel.monthlyGrossRateProfit, "0,63%")
        XCTAssertEqual(viewController.viewModel.rate, "100%")
        XCTAssertEqual(viewController.viewModel.annualGrossRateProfit, "16,53%")
        XCTAssertEqual(viewController.viewModel.rateProfit, "7,77%")
    }

    func testDisplayErrorAlert() {
        let viewController = FormViewControllerSpy()
        presenter.viewController = viewController

        let errorMessage = "MENSAGEM_DE_ERRO"
        presenter.presentErrorAlert(message: errorMessage)

        XCTAssertEqual(viewController.errorMessage, errorMessage)
    }

    class FormViewControllerSpy: FormDisplayLogic {
        var errorMessage = ""
        var viewModel: Form.ViewModel!

        func displaySimulation(viewModel: Form.ViewModel) {
            self.viewModel = viewModel
        }

        func displayErrorAlert(with message: String) {
            self.errorMessage = message
        }
    }
}
