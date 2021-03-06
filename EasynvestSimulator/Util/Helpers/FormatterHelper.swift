//
//  FormatterHelper.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation
import UIKit

class FormatterHelper {
    static func convert(date: String, from format: String, to finalFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        guard let timestamp = dateFormatter.date(from: date) else { return "" }

        dateFormatter.dateFormat = finalFormat

        return dateFormatter.string(from: timestamp)
    }

    static func formatIn(currency value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(for: value)!
    }

    static func formatIn(percent value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: value as NSNumber)!.replace(symbols: ["."], with: ",") + "%"
    }

    static func paint(value: String) -> NSAttributedString {
        let fixedText = "Rendimento total de "

        let gray = UIColor(named: "Gray")!
        let green = UIColor(named: "Green")!

        let font = UIFont.preferredFont(forTextStyle: .caption1)
        let grayText: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: gray,
                                                       NSAttributedString.Key.font: font]
        let greenText: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: green,
                                                        NSAttributedString.Key.font: font]

        let attributedFixedText = NSMutableAttributedString(attributedString: NSAttributedString(string: fixedText))
        attributedFixedText.addAttributes(grayText, range: NSRange(location: 0, length: attributedFixedText.length))

        let attributedValueText = NSMutableAttributedString(attributedString: NSAttributedString(string: value))
        attributedValueText.addAttributes(greenText, range: NSRange(location: 0, length: attributedValueText.length))

        let result: NSMutableAttributedString = attributedFixedText
        result.append(attributedValueText)

        return result
    }
}
