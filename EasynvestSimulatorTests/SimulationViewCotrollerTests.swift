//
//  SimulationViewCotrollerTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 17/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class SimulationViewCotrollerTests: XCTestCase {
    var viewController: SimulationViewController!
    var window: UIWindow!

    override func setUp() {
        super.setUp()
        window = UIWindow()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "SimulationViewController")
            as? SimulationViewController
    }

    override func tearDown() {
        window = nil
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
    
    func testSimulateAgainButton() {
        //TODO: TENTAR FAZER ESSE TESTE
    }
}
