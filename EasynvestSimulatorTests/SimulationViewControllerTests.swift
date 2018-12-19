//
//  SimulationViewCotrollerTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 17/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class SimulationViewControllerTests: XCTestCase {
    var viewController: SimulationViewController!
    var window: UIWindow!
    var bundle: Bundle!
    var storyboard: UIStoryboard!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        bundle = Bundle.main
        storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "SimulationViewController")
            as? SimulationViewController
    }

    override func tearDown() {
        window = nil
        viewController = nil
        super.tearDown()
    }

    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    func testLoadingViewWithSimulationData() {
        viewController.simulation = Seeds.FormViewModel.viewModel

        loadView()

        XCTAssertNotEqual(viewController.titleGrossAmountLabel.text, "---")
    }

    func testLoadingViewWithoutSimulationData() {
        viewController.simulation = nil

        loadView()

        XCTAssertEqual(viewController.titleGrossAmountLabel.text, "R$ 0,00")
    }

//    func testSimulateAgainButton() {
//        loadView()
//
//        viewController.simulateAgain(viewController)
//
//        XCTAssertTrue(viewController)
//    }

    func testUnwindSegueToFormViewController() {
        loadView()

        let formVC = (storyboard.instantiateViewController(withIdentifier: "FormViewController")
            as? FormViewController)!
        _ = formVC.view

        let unwindSegue = UIStoryboardSegue(identifier: "unwindToFormVC",
                                            source: viewController,
                                            destination: formVC)
        formVC.unwindToFormVC(segue: unwindSegue)

        XCTAssertEqual(formVC.investedAmountTextField.placeholder, "R$")
        XCTAssertEqual(formVC.maturityDateTextField.placeholder, "dia/mês/ano")
        XCTAssertEqual(formVC.rateTextField.placeholder, "100%")
    }
}
