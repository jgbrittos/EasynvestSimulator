//
//  SimulationViewController.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
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
            self.setupData()
        } else {
            self.showBlankView()
        }
    }

    func setupData() {
        self.titleGrossAmountLabel.text = self.simulation!.grossAmount
        self.titleGrossAmountProfitLabel.attributedText =
            FormatterHelper.paint(value: self.simulation!.grossAmountProfit)
        self.investedAmountLabel.text = self.simulation!.investedAmount
        self.grossAmountLabel.text = self.simulation!.grossAmount
        self.grossAmountProfitLabel.text = self.simulation!.grossAmountProfit
        self.taxesAmountAndRateLabel.text = self.simulation!.taxesAmountAndRate
        self.netAmountLabel.text = self.simulation!.netAmount
        self.maturityDateLabel.text = self.simulation!.maturityDate
        self.maturityTotalDaysLabel.text = String(describing: simulation!.maturityTotalDays)
        self.monthlyGrossRateProfitLabel.text = self.simulation!.monthlyGrossRateProfit
        self.rateLabel.text = self.simulation!.rate
        self.annualGrossRateProfitLabel.text = self.simulation!.annualGrossRateProfit
        self.rateProfitLabel.text = self.simulation!.rateProfit
    }

    func showBlankView() {
        self.titleGrossAmountLabel.text = "R$ 0,00"
        self.titleGrossAmountProfitLabel.text = "Rendimento de R$ 0,00"
        self.investedAmountLabel.text = "R$ 0,00"
        self.grossAmountLabel.text = "R$ 0,00"
        self.grossAmountProfitLabel.text = "R$ 0,00"
        self.taxesAmountAndRateLabel.text = "R$ 0,00(0%)"
        self.netAmountLabel.text = "R$ 0,00"
        self.maturityDateLabel.text = "dia/mês/ano"
        self.maturityTotalDaysLabel.text = "0"
        self.monthlyGrossRateProfitLabel.text = "0%"
        self.rateLabel.text = "0%"
        self.annualGrossRateProfitLabel.text = "0%"
        self.rateProfitLabel.text = "0%"
    }
}
