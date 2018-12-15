//
//  SimulationViewController.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController {
    //Title
    @IBOutlet weak var titleGrossAmountLabel: UILabel!
    @IBOutlet weak var titleGrossAmountProfitLabel: UILabel!

    //First block
    @IBOutlet weak var investedAmountLabel: UILabel!
    @IBOutlet weak var grossAmountLabel: UILabel!
    @IBOutlet weak var grossAmountProfitLabel: UILabel!
    @IBOutlet weak var taxesAmountAndRateLabel: UILabel!
    @IBOutlet weak var netAmountLabel: UILabel!

    //Second block
    @IBOutlet weak var maturityDateLabel: UILabel!
    @IBOutlet weak var maturityTotalDaysLabel: UILabel!
    @IBOutlet weak var monthlyGrossRateProfitLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var annualGrossRateProfitLabel: UILabel!
    @IBOutlet weak var rateProfitLabel: UILabel!

    var simulation: Form.ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.displaySimulationDetail()
        }
    }

    func displaySimulationDetail() {
        if self.simulation != nil {
            self.setupTitle()
            self.setupFirstBlock()
            self.setupSecondBlock()
        } else {
            self.showBlankView()
        }
    }

    func setupTitle() {
        self.titleGrossAmountLabel.text = self.simulation?.grossAmount ?? "---"
        self.titleGrossAmountProfitLabel.attributedText =
            FormatterHelper.paint(value: self.simulation?.grossAmountProfit ?? "---")
    }

    func setupFirstBlock() {
        self.investedAmountLabel.text = self.simulation?.investedAmount ?? "---"
        self.grossAmountLabel.text = self.simulation?.grossAmount ?? "---"
        self.grossAmountProfitLabel.text = self.simulation?.grossAmountProfit ?? "---"
        self.taxesAmountAndRateLabel.text = self.simulation?.taxesAmountAndRate ?? "---"
        self.netAmountLabel.text = self.simulation?.netAmount ?? "---"
    }

    func setupSecondBlock() {
        self.maturityDateLabel.text = self.simulation?.maturityDate ?? "---"
        self.maturityTotalDaysLabel.text = String(describing: self.simulation?.maturityTotalDays ?? 0)
        self.monthlyGrossRateProfitLabel.text = self.simulation?.monthlyGrossRateProfit ?? "---"
        self.rateLabel.text = self.simulation?.rate ?? "---"
        self.annualGrossRateProfitLabel.text = self.simulation?.annualGrossRateProfit ?? "---"
        self.rateProfitLabel.text = self.simulation?.rateProfit ?? "---"
    }

    func showBlankView() {
    }

    @IBAction func simulateAgain(_ sender: Any) {
        performSegue(withIdentifier: "unwindToFormVC", sender: self)
    }
}
