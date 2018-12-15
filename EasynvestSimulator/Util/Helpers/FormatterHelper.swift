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
        let timestamp = dateFormatter.date(from: date)
        dateFormatter.dateFormat = finalFormat
        return dateFormatter.string(from: timestamp ?? Date())
    }

    static func formatIn(currency value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(for: value) ?? "R$ 0,00"
    }

    static func formatIn(percent value: Double) -> String {
        return String(format: "%.02f", value) + "%"
    }

    static func paint(value: String) -> NSAttributedString {
        let fixedText = "Rendimento total de "

        let gray = UIColor(named: "Gray") ?? .gray
        let green = UIColor(named: "Green") ?? .green

        let grayText: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: gray]
        let greenText: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: green]

        let attributedFixedText = NSMutableAttributedString(attributedString: NSAttributedString(string: fixedText))
        attributedFixedText.addAttributes(grayText, range: NSRange(location: 0, length: attributedFixedText.length))

        let attributedValueText = NSMutableAttributedString(attributedString: NSAttributedString(string: value))
        attributedValueText.addAttributes(greenText, range: NSRange(location: 0, length: attributedValueText.length))

        let result: NSMutableAttributedString = attributedFixedText
        result.append(attributedValueText)

        return result
    }
}
