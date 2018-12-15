//
//  UIViewController+Extension.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation
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

    func removeObserversWhenViewWillDisappear(_ viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(viewController,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
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
