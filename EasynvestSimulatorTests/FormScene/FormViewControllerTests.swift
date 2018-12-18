//
//  FormViewControllerTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 17/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormViewControllerTests: XCTestCase {
    var viewController: FormViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "FormViewController")
            as? FormViewController
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    func testPlaceholderTexts() {
        loadView()

        XCTAssertEqual(viewController.investedAmountTextField.placeholder, "R$")
        XCTAssertEqual(viewController.maturityDateTextField.placeholder, "dia/mês/ano")
        XCTAssertEqual(viewController.rateTextField.placeholder, "100%")
    }

    func testSimulateButtonAction() {
        loadView()

        viewController.simulate(0)

        XCTAssertFalse(viewController.simulateButton.isEnabled)
    }

    func testToolbarDoneButtonControlingFirstResponder() {
        loadView()

        let doneBarButton = UIBarButtonItem()
        doneBarButton.tag = 0

        viewController.doneButtonAction(doneBarButton)

        XCTAssertFalse(viewController.investedAmountTextField.isFirstResponder)
        XCTAssertTrue(viewController.maturityDateTextField.isFirstResponder)

        doneBarButton.tag = 1

        viewController.doneButtonAction(doneBarButton)

        XCTAssertFalse(viewController.maturityDateTextField.isFirstResponder)
        XCTAssertTrue(viewController.rateTextField.isFirstResponder)

        doneBarButton.tag = 2

        viewController.doneButtonAction(doneBarButton)

        XCTAssertFalse(viewController.rateTextField.isFirstResponder)
    }

    func testToolbarCancelButtonCancelingFirstResponder() {
        loadView()

        let doneBarButton = UIBarButtonItem()
        doneBarButton.tag = 0

        viewController.cancelButtonAction(doneBarButton)

        XCTAssertFalse(viewController.investedAmountTextField.isFirstResponder)

        doneBarButton.tag = 1

        viewController.cancelButtonAction(doneBarButton)

        XCTAssertFalse(viewController.maturityDateTextField.isFirstResponder)

        doneBarButton.tag = 2

        viewController.cancelButtonAction(doneBarButton)

        XCTAssertFalse(viewController.rateTextField.isFirstResponder)
    }

    func testInvestedAmountTextFieldMaskingCurrency() {
        loadView()

        viewController.investedAmountTextField.text = "100000"

        viewController.myTextFieldDidChange(viewController.investedAmountTextField)

        XCTAssertEqual(viewController.investedAmountTextField.text!.count,
                       "R$ 1.000,00".count,
                       "Texto após formatação pela máscara: \(viewController.investedAmountTextField.text ?? "ERRO")")
    }

    func testMaturityDateTextFieldMaskingDateInEdition() {
        loadView()

        viewController.maturityDateTextField.text = "15122"

        let range = NSRange(location: 5, length: 0)
        let result = viewController.textField(viewController.maturityDateTextField,
                                              shouldChangeCharactersIn: range,
                                              replacementString: "0")

        XCTAssertFalse(result)
        XCTAssertEqual(viewController.maturityDateTextField.text, "15/12/20")
    }

    func testOtherTextFieldMaskingDate() {
        loadView()

        let range = NSRange(location: 0, length: 0)
        let result = viewController.textField(viewController.investedAmountTextField,
                                              shouldChangeCharactersIn: range,
                                              replacementString: "0")

        XCTAssertTrue(result)
    }

    func testDisplaySimulation() {
        loadView()
        viewController.displaySimulation(viewModel: Seeds.FormViewModel.viewModel)
        XCTAssert(viewController.simulateButton.isEnabled)
    }
}
