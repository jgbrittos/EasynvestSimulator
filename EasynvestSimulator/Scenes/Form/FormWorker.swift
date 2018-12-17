//
//  FormWorker.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

class FormWorker: NetworkDependency, ConsoleLogDependency {
    private lazy var networkHandler: JGNetwork = network
    private lazy var consoleLogger: JGLogger = logger

    func simulate(with request: Form.Request,
                  success: @escaping (Form.Response) -> Void,
                  fail: @escaping (String) -> Void) {
        let maturityDate = checkAndFormatMaturityDate(date: request.maturityDate)
        guard !maturityDate.isEmpty else { return fail(FormMessages.kInvalidMaturityDate) }

        let investment = checkAndConvertInvestedAmount(investedAmount: request.investedAmount)
        guard let investedAmount = investment, !investedAmount.isZero else {
            return fail(FormMessages.kInvalidInvestedAmount)
        }

        let tax = checkAndConvertRate(rate: request.rate)
        guard let rate = tax, rate != 0 else { return fail(FormMessages.kInvalidRate) }

        let params: AnyParameters = ["investedAmount": investedAmount,
                                     "index": "CDI", //fixed param
                                     "rate": rate,
                                     "isTaxFree": false, //fixed param
                                     "maturityDate": maturityDate]

        networkHandler.getRequest(for: API.url, with: params, success: { (result) in
            do {
                let formResponse = try JSONDecoder().decode(Form.Response.self, from: result)
                success(formResponse)
            } catch let error {
                self.consoleLogger.log(error, with: ConsoleMessages.kDecodeErrorTag, and: JGLDefaultOptions)
            }
        }, failure: { (message) in
            fail(message)
        })
    }

    private func checkAndFormatMaturityDate(date: String?) -> String {
        guard let date = date, !date.isEmpty else {
            return ""
        }

        return FormatterHelper.convert(date: date, from: DateFormats.kHumanReadable, to: DateFormats.kAPIRequest)
    }

    private func checkAndConvertInvestedAmount(investedAmount: String?) -> Double? {
        guard let investedAmount = investedAmount, !investedAmount.isEmpty else {
            return 0.0
        }

        return Double(investedAmount.sanitizeCurrency)
    }

    private func checkAndConvertRate(rate: String?) -> Int? {
        guard let rate = rate, !rate.isEmpty else {
            return 0
        }

        return Int(rate.sanitizePercentual)
    }
}
