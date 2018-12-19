//
//  TestSeeds.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 17/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

struct Seeds {
    struct FormWrongRequest {
        static let emptyDateRequest = Form.Request(investedAmount: "100",
                                                   rate: "100",
                                                   maturityDate: "")
        static let wrongDateFormatRequest = Form.Request(investedAmount: "100",
                                                         rate: "100",
                                                         maturityDate: "12122019")
        static let wrongDateRequest = Form.Request(investedAmount: "100",
                                                   rate: "100",
                                                   maturityDate: "15/12/1020")
        static let emptyInvestedAmountRequest = Form.Request(investedAmount: "",
                                                             rate: "100",
                                                             maturityDate: "15/12/2020")
        static let emptyRateRequest = Form.Request(investedAmount: "1000",
                                                   rate: "",
                                                   maturityDate: "15/12/2020")
    }

    struct FormRequest {
        static let request = Form.Request(investedAmount: "100", rate: "100", maturityDate: "15/12/2020")
    }

    struct FormResponse: Codable {
        static let response = Form.Response(investmentParameter:
            Form.ResponseInvestmentParameter(investedAmount: 100,
                                             yearlyInterestRate: 7.7734,
                                             maturityTotalDays: 729,
                                             maturityBusinessDays: 515,
                                             maturityDate: "2020-12-15T00:00:00",
                                             rate: 100,
                                             isTaxFree: false),
                                            grossAmount: 116.53,
                                            taxesAmount: 2.48,
                                            netAmount: 114.05,
                                            grossAmountProfit: 16.53,
                                            netAmountProfit: 14.05,
                                            annualGrossRateProfit: 16.53,
                                            monthlyGrossRateProfit: 0.63,
                                            dailyGrossRateProfit: 0.000297110353903562,
                                            taxesRate: 15,
                                            rateProfit: 7.7734,
                                            annualNetRateProfit: 14.05)
    }

    struct FormViewModel {
        private static let investedAmount = FormatterHelper
            .formatIn(currency: FormResponse.response.investmentParameter.investedAmount)
        private static let grossAmount = FormatterHelper.formatIn(currency: FormResponse.response.grossAmount)
        private static let grossAmountProfit = FormatterHelper
            .formatIn(currency: FormResponse.response.grossAmountProfit)

        private static let taxesAmount = FormatterHelper.formatIn(currency: FormResponse.response.taxesAmount)
        private static let taxesRate = FormatterHelper.formatIn(percent: FormResponse.response.taxesRate)
        private static let taxesAmountAndRate = taxesAmount + "(\(taxesRate))"
        private static let netAmount = FormatterHelper.formatIn(currency: FormResponse.response.netAmount)
        private static let maturityDate = FormatterHelper
            .convert(date: FormResponse.response.investmentParameter.maturityDate,
                     from: DateFormats.kAPIResponse,
                     to: DateFormats.kHumanReadable)
        private static let maturityTotalDays = FormResponse.response.investmentParameter.maturityTotalDays
        private static let monthlyGrossRateProfit = FormatterHelper
            .formatIn(percent: FormResponse.response.monthlyGrossRateProfit)
        private static let rate = FormatterHelper.formatIn(percent: FormResponse.response.investmentParameter.rate)
        private static let annualGrossRateProfit = FormatterHelper
            .formatIn(percent: FormResponse.response.annualGrossRateProfit)
        private static let rateProfit = FormatterHelper.formatIn(percent: FormResponse.response.rateProfit)

        static let viewModel = Form.ViewModel(investedAmount: investedAmount,
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
    }

    struct NetworkRequest {
        static let params: AnyParameters = ["investedAmount": FormRequest.request.investedAmount!,
                                            "index": "CDI", //fixed param
                                            "rate": FormRequest.request.rate!,
                                            "isTaxFree": false, //fixed param
                                            "maturityDate": "2020-12-15"]

        static let wrongParams: AnyParameters = ["investedAmount": FormWrongRequest.emptyDateRequest.investedAmount!,
                                                 "index": "CDI", //fixed param
                                                 "rate": FormWrongRequest.emptyDateRequest.rate!,
                                                 "isTaxFree": false, //fixed param
                                                 "maturityDate": FormWrongRequest.emptyDateRequest.maturityDate!]

        static let internalServerErrorParams: AnyParameters =
            ["investedAmount": FormWrongRequest.wrongDateRequest.investedAmount!,
             "index": "CDI", //fixed param
             "rate": FormWrongRequest.wrongDateRequest.rate!,
             "isTaxFree": false, //fixed param
             "maturityDate": FormWrongRequest.wrongDateRequest.maturityDate!]

        static let wrongKeyParams: AnyParameters = ["investedAmount1": FormRequest.request.investedAmount!,
                                                    "index": "CDI", //fixed param
                                                    "rate": FormRequest.request.rate!,
                                                    "isTaxFree": false, //fixed param
                                                    "maturityDate": "2020-12-15"]
    }
}
