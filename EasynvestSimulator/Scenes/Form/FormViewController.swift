//
//  FormViewController.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

protocol FormDisplayLogic: class {
    func displaySimulation(viewModel: Form.ViewModel)
    func displayErrorAlert(with message: String)
}

class FormViewController: UIViewController, FormDisplayLogic {
    @IBOutlet weak var investedAmountTextField: UITextField!
    @IBOutlet weak var maturityDateTextField: UITextField!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var simulateButton: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    var interactor: FormBusinessLogic?
    var router: (NSObjectProtocol & FormRoutingLogic)?

    // MARK: Initial VIP Cycle setup
    private func setup() {
        let viewController = self
        let interactor = FormInteractor()
        let presenter = FormPresenter()
        let router = FormRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        hideKeyboardWhenTapScreen()
        setupTextFieldsToolbar()
        setupCurrencyTextFieldsWithMask()

        self.maturityDateTextField.delegate = self
        self.rateTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        liftViewWithKeyboard(self)
        self.cleanForm()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversWhenViewWillDisappear(self)
    }

    // MARK: View Actions
    @IBAction func simulate(_ sender: Any) {
        self.loading.startAnimating()
        self.simulateButton.isEnabled = false

        let investedAmount = investedAmountTextField.text
        let maturityDate = maturityDateTextField.text
        let rate = rateTextField.text

        let request = Form.Request(investedAmount: investedAmount, rate: rate, maturityDate: maturityDate)
        interactor?.simulateInvestment(with: request)
    }

    @IBAction func unwindToFormVC(segue: UIStoryboardSegue) { }

    // MARK: Private methods
    private func cleanForm() {
        self.investedAmountTextField.text = ""
        self.maturityDateTextField.text = ""
        self.rateTextField.text = ""
    }

    private func stopLoading() {
        self.loading.stopAnimating()
    }
}

// MARK: FormDisplayLogic
extension FormViewController {
    func displaySimulation(viewModel: Form.ViewModel) {
        self.router?.routeToSimulationResult(viewModel: viewModel)
        DispatchQueue.main.async {
            self.stopLoading()
            self.simulateButton.isEnabled = true
        }
    }

    func displayErrorAlert(with message: String) {
        DispatchQueue.main.async {
            self.stopLoading()
            self.simulateButton.isEnabled = true
            let alertController = UIAlertController(title: GenericMessages.kAlertTitle,
                                                    message: message,
                                                    preferredStyle: .alert)

            let okAction = UIAlertAction(title: GenericMessages.kAlertDoneActionText,
                                         style: .default,
                                         handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
    }
}

// MARK: Toolbars
extension FormViewController {
    func setupTextFieldsToolbar() {
        self.addToolbarTo(textField: investedAmountTextField)
        self.addToolbarTo(textField: maturityDateTextField)
        self.addToolbarTo(textField: rateTextField)
    }

    func addToolbarTo(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: GenericMessages.kToolbarNext,
                                            style: .done,
                                            target: self,
                                            action: #selector(self.doneButtonAction(_:)))
        let cancelBarButton = UIBarButtonItem(title: GenericMessages.kToolbarCancel,
                                              style: .done,
                                              target: self,
                                              action: #selector(self.cancelButtonAction(_:)))
        doneBarButton.tag = textField.tag
        cancelBarButton.tag = textField.tag
        keyboardToolbar.items = [cancelBarButton, flexBarButton, doneBarButton]

        textField.inputAccessoryView = keyboardToolbar
    }

    @objc
    func doneButtonAction(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            self.investedAmountTextField.resignFirstResponder()
            self.maturityDateTextField.becomeFirstResponder()
        case 1:
            self.maturityDateTextField.resignFirstResponder()
            self.rateTextField.becomeFirstResponder()
        default:
            self.rateTextField.resignFirstResponder()
        }
    }

    @objc
    func cancelButtonAction(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0: self.investedAmountTextField.resignFirstResponder()
        case 1: self.maturityDateTextField.resignFirstResponder()
        default: self.rateTextField.resignFirstResponder()
        }
    }
}

// MARK: Masks
extension FormViewController: UITextFieldDelegate {
    func setupCurrencyTextFieldsWithMask() {
        self.investedAmountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }

    @objc
    func myTextFieldDidChange(_ textField: UITextField) {
        if let investedAmount = textField.text?.currencyInputFormatting() {
            textField.text = investedAmount
        }
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == self.maturityDateTextField {
            return Mask.date(textField, shouldChangeCharactersIn: range, replacementString: string)
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.rateTextField {
            textField.text = ""
            textField.text = textField.text! + "%"
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument,
                                                              to: textField.beginningOfDocument)
        }
    }
}
