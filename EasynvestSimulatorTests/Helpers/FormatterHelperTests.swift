//
//  FormatterHelperTests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 16/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class FormatterHelperTests: XCTestCase {
    func testFormatInCurrency() {
        XCTAssertEqual(FormatterHelper.formatIn(currency: 1000.0).sanitizeCurrency, "1000.00")
    }

    func testFormatInPercentValue() {
        XCTAssertEqual(FormatterHelper.formatIn(percent: 100.0), "100%")
    }

    func testPaintValueInGreen() {
        let attributedText = FormatterHelper.paint(value: "R$ 88,69")
        XCTAssertEqual(attributedText.string, "Rendimento total de R$ 88,69")
    }
}
/*
 TESTAR O CODIGO A SEGUIR NO PLAYGROUND
 POR ALGUM MOTIVO O ULTIMO PRINT QUE COMPARA SE AS STRINGS SÃO IGUAIS DA SEMPRE FALSE
 O QUE NÃO FAZ SENTIDO, DADO QUE AS STRINGS SÃO EXATAMENTE IGUAIS
 🧐
 
 let value: NSNumber = 1000.0
 let str = "R$ 1.000,00"
 
 let formatter = NumberFormatter()
 formatter.locale = Locale(identifier: "pt_BR")
 formatter.numberStyle = .currency
 
 let asd = formatter.string(for: value) ?? "R$ 0,00"
 print(asd)
 print(str)
 print(asd != "R$ 0,00")
 print(asd == str)
*/
