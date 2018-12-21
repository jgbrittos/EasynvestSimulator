//
//  ConsoleLoggerDIITests.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel on 18/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
@testable import EasynvestSimulator

class ConsoleLoggerDIITests: XCTestCase {
    var logger: JGLogger!

    override func setUp() {
        super.setUp()
        logger = ConsoleLoggerDII()
    }

    override func tearDown() {
        logger = nil
        super.tearDown()
    }

    func testLogingError() {
        let error: Error = TestError.testError

        logger.log(error, with: "[Easynvest/TEST]", and: [])
        XCTAssertEqual(logger.logBuilder?.build(), "\n[Easynvest/TEST]\nMENSAGEM_DE_ERRO\n")
    }
}

enum TestError: Error {
    case testError
}

extension TestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .testError:
            return NSLocalizedString("MENSAGEM_DE_ERRO", comment: "MENSAGEM DE ERRO PARA TESTE")
        }
    }
}
