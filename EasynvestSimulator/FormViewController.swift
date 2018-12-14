//
//  FormViewController.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc
    func hideKeyboardWhenTapScreen() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func liftViewWithKeyboard(_ viewController: UIViewController) {
        NotificationCenter.default.addObserver(viewController,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(viewController,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    func removeObserversWhenViewWillDisappear() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
            as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2.0
            }
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

class FormViewController: UIViewController {
    @IBOutlet weak var investedAmountTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTapScreen()
        liftViewWithKeyboard(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversWhenViewWillDisappear()
    }
}
