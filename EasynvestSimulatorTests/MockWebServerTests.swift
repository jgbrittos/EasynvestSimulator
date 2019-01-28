//
//  MockWebServer.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel de Britto e Silva on 28/01/19.
//  Copyright © 2019 João Gabriel de Britto e Silva. All rights reserved.
//

import XCTest
import Embassy
@testable import EasynvestSimulator

class MockWebServerTests: XCTestCase {
    
    let queue = DispatchQueue(label: "br.com.easynvest.mock.http-server", attributes: [])
    var loop: SelectorEventLoop!
    var session: URLSession!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testMockWebServer() {
        MockWebServer().withResponse("mockData") { (data, httpResponse, error) in
            print("--------")
            print(String(bytes: data ?? Data(), encoding: .utf8)!)
            print("--------")
        }
    }
}
