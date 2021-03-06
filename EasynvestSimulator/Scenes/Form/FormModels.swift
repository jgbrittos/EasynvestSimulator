//
//  FormModels.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

enum Form {
    struct Request {
        var investedAmount: String?
        var rate: String?
        var maturityDate: String?
    }

    struct Response: Codable {
        var investmentParameter: ResponseInvestmentParameter
        var grossAmount: Double
        var taxesAmount: Double
        var netAmount: Double
        var grossAmountProfit: Double
        var netAmountProfit: Double
        var annualGrossRateProfit: Double
        var monthlyGrossRateProfit: Double
        var dailyGrossRateProfit: Double
        var taxesRate: Double
        var rateProfit: Double
        var annualNetRateProfit: Double
    }

    struct ResponseInvestmentParameter: Codable {
        var investedAmount: Double
        var yearlyInterestRate: Double
        var maturityTotalDays: Int
        var maturityBusinessDays: Int
        var maturityDate: String
        var rate: Double
        var isTaxFree: Bool
    }

    struct ViewModel {
        var investedAmount: String
        var grossAmount: String
        var grossAmountProfit: String
        var taxesAmountAndRate: String
        var netAmount: String
        var maturityDate: String
        var maturityTotalDays: Int
        var monthlyGrossRateProfit: String
        var rate: String
        var annualGrossRateProfit: String
        var rateProfit: String
    }
}
