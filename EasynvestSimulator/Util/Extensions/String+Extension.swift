//
//  String+Extension.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }

    var sanitizeCurrency: String {
        return self.replace(symbols: ["R$", " ", "."])
            .replace(symbols: [","], with: ".")
    }

    var sanitizePercentual: String {
        return self.replace(symbols: ["%"])
    }

    func currencyInputFormatting() -> String {
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencySymbol = "R$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2

        var amountWithPrefix = self

        // remove from String: "R$", ".", ","
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                              options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                              range: NSRange(location: 0, length: self.count),
                                                              withTemplate: "")

            let double = (amountWithPrefix as NSString).doubleValue
            number = NSNumber(value: (double / 100))
        } catch let error {
            print(error.localizedDescription)
        }

        return formatter.string(from: number)!
    }

    func replace(symbols: [String], with symbol: String = "") -> String {
        var sanitizedString: String = self

        for sym in symbols {
            sanitizedString = sanitizedString.replacingOccurrences(of: sym, with: symbol)
        }

        return sanitizedString.trimmingCharacters(in: .whitespaces)
    }
}
