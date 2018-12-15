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
        let investedAmount = checkAndConvertInvestedAmount(investedAmount: request.investedAmount)
        let rate = checkAndConvertRate(rate: request.rate)

        guard !maturityDate.isEmpty else {
            return fail("Algum problema ocorreu com a data. Tente novamente!")
        }

        guard !investedAmount.isZero else {
            return fail("Algum problema ocorreu com a total a ser investido. Tente novamente!")
        }

        guard rate != 0 else {
            return fail("Algum problema ocorreu com o percentual do papel. Tente novamente!")
        }

        let params: AnyParameters = ["investedAmount": investedAmount,
                                     "index": "CDI", //fixed param
                                     "rate": rate,
                                     "isTaxFree": false, //fixed param
                                     "maturityDate": maturityDate]

        let url = "https://api-simulator-calc.easynvest.com.br/calculator/simulate"
        networkHandler.getRequest(for: url, with: params, success: { (result) in
            do {
                let formResponse = try JSONDecoder().decode(Form.Response.self, from: result)
                success(formResponse)
            } catch let error {
                self.consoleLogger.log(error, with: "[Easynvest/Decode_Error]", and: JGLDefaultOptions)
            }
        }, failure: { (message) in
            fail(message)
        })
    }

    private func checkAndFormatMaturityDate(date: String?) -> String {
        guard let date = date, !date.isEmpty else {
            return ""
        }

        return FormatterHelper.convert(date: date, from: "dd/MM/yyyy", to: "yyyy-MM-dd")
    }

    private func checkAndConvertInvestedAmount(investedAmount: String?) -> Double {
        guard let investedAmount = investedAmount, !investedAmount.isEmpty else {
            return 0.0
        }

        return Double(investedAmount) ?? 0.0
    }

    private func checkAndConvertRate(rate: String?) -> Int {
        guard let rate = rate, !rate.isEmpty else {
            return 0
        }

        return Int(rate) ?? 0
    }
}
