//
//  MaskHelper.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation
import UIKit

class Mask: NSObject {
    static func date(_ textField: UITextField,
                     shouldChangeCharactersIn range: NSRange,
                     replacementString string: String) -> Bool {
        if !onlyDigits(string) {
            return false
        }

        var currentString = textField.text ?? ""

        //Clear text
        if string.isEmpty {
            return true
        }

        if currentString.count >= 10 {
            return false
        }

        // DATE 99/99/9999
        currentString = currentString.appending(string)
        currentString = currentString.digits
        var formattedNumber = ""

        for index in 0..<currentString.count {
            let stringIndex = currentString.index(currentString.startIndex, offsetBy: index)
            let digit = currentString[stringIndex]

            switch index {
            case 1, 3:
                formattedNumber += ("\(digit)/")
            default:
                formattedNumber += ("\(digit)")
            }
        }

        textField.text = formattedNumber

        return false
    }

    static func onlyDigits(_ string: String) -> Bool {
        let digits = string.digits
        if string.count > digits.count {
            return false
        }
        return true
    }
}
