//
//  FormatterHelper.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 15/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

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
}
