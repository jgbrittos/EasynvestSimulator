//
//  FormPresenter.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FormPresentationLogic {
    func presentSimulation(response: Form.Response)
    func presentErrorAlert(message: String)
}

class FormPresenter: FormPresentationLogic {

    weak var viewController: FormDisplayLogic?

    func presentSimulation(response: Form.Response) {
    
        let investedAmount = FormatterHelper.formatIn(currency: response.investmentParameter.investedAmount)
        let grossAmount = FormatterHelper.formatIn(currency: response.grossAmount)
        let grossAmountProfit = FormatterHelper.formatIn(currency: response.grossAmountProfit)
        let taxesAmountAndRate = FormatterHelper.formatIn(currency: response.taxesAmount) + "(\(FormatterHelper.formatIn(percent: response.taxesRate)))"
        let netAmount = FormatterHelper.formatIn(currency: response.netAmount)
        let maturityDate = FormatterHelper.convert(date: response.investmentParameter.maturityDate, from: "yyyy-MM-dd'T'HH:mm:ss", to: "dd/MM/yyyy")
        let maturityTotalDays = response.investmentParameter.maturityTotalDays
        let monthlyGrossRateProfit = FormatterHelper.formatIn(percent: response.monthlyGrossRateProfit)
        let rate = FormatterHelper.formatIn(percent: response.investmentParameter.rate)
        let annualGrossRateProfit = FormatterHelper.formatIn(percent: response.annualGrossRateProfit)
        let rateProfit = FormatterHelper.formatIn(percent: response.rateProfit)
        
        let viewModel = Form.ViewModel(investedAmount: investedAmount,
                                       grossAmount: grossAmount,
                                       grossAmountProfit: grossAmountProfit,
                                       taxesAmountAndRate: taxesAmountAndRate,
                                       netAmount: netAmount,
                                       maturityDate: maturityDate,
                                       maturityTotalDays: maturityTotalDays,
                                       monthlyGrossRateProfit: monthlyGrossRateProfit,
                                       rate: rate,
                                       annualGrossRateProfit: annualGrossRateProfit,
                                       rateProfit: rateProfit)
     
        viewController?.displaySimulation(viewModel: viewModel)
    }
    
    func presentErrorAlert(message: String) {
        viewController?.displayErrorAlert(with: message)
    }
}