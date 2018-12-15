//
//  SimulationViewController.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {
    var simulation: Form.ViewModel?

    func displaySimulationDetail() {
        if let simulation = self.simulation {
            print(simulation)
            //TODO: - MOSTRAR DADOS NA VIEW
        }
    }

    @IBAction func simulateAgain(_ sender: Any) {
        performSegue(withIdentifier: "unwindToFormVC", sender: self)
    }
}
