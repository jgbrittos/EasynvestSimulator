//
//  FormRouter.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

protocol FormRoutingLogic {
    func routeToSimulationResult(viewModel: Form.ViewModel)
}

class FormRouter: NSObject, FormRoutingLogic {
    weak var viewController: FormViewController?

    func routeToSimulationResult(viewModel: Form.ViewModel) {
        guard let destinationVC = viewController?.storyboard?
            .instantiateViewController(withIdentifier: "SimulationViewController") as? SimulationViewController else {
                return
        }

        destinationVC.simulation = viewModel
        if let viewController = self.viewController {
            navigateToSimulationDetail(source: viewController, destination: destinationVC)
        }
    }

    func navigateToSimulationDetail(source: FormViewController, destination: SimulationViewController) {
        DispatchQueue.main.async {
            source.show(destination, sender: nil)
        }
    }
}
