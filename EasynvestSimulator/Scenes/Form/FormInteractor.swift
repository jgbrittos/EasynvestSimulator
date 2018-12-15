//
//  FormInteractor.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

protocol FormBusinessLogic {
    func simulateInvestment(with request: Form.Request)
}

class FormInteractor: FormBusinessLogic {
    var presenter: FormPresentationLogic?
    var worker: FormWorker?

    func simulateInvestment(with request: Form.Request) {
        worker = FormWorker()

        worker?.simulate(with: request, success: { (response) in
            self.presenter?.presentSimulation(response: response)
        }, fail: { (message) in
            self.presenter?.presentErrorAlert(message: message)
        })
    }
}
