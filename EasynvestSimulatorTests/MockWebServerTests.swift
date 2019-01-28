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
        MockWebServer(timeout: 15).withResponse("mockData") { (data, httpResponse, error) in
            print("--------")
            print(String(bytes: data ?? Data(), encoding: .utf8)!)
            print("--------")
        }
    }
}
//    func testExample() {
//        loop = try! SelectorEventLoop(selector: try! KqueueSelector())
//
//        session = URLSession(configuration: .default)
//        // set a 30 seconds timeout
//        queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(30 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
//            if self.loop.running {
//                self.loop.stop()
//                XCTFail("Time out")
//            }
//        }
//
//        let port = try! MockWebServer().getUnusedTCPPort()
//        let bigDataChunk = MockWebServer().getMockDataFromJson(named: "mockData")
//        let server = DefaultHTTPServer(eventLoop: loop, port: port) { (
//            environ: AnyParameter,
//            startResponse: StartResponse,
//            sendBody: SendBody
//            ) in
//            startResponse("200 OK", [])
//            sendBody(bigDataChunk)
//            sendBody(Data())
//        }
//
//        try! server.start()
//
//        var receivedData: Data?
//        var receivedResponse: HTTPURLResponse?
//        var receivedError: Error?
//        queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
//            let task = self.session.dataTask(with: URL(string: "http://[::1]:\(port)")!,
//                                             completionHandler: { (data, response, error) in
//                                                receivedData = data
//                                                receivedResponse = response as? HTTPURLResponse
//                                                receivedError = error
//                                                self.loop.stop()
//            })
//            task.resume()
//        }
//
//        loop.runForever()
//
//        let data = receivedData ?? Data()
//        print(String(bytes: data, encoding: .utf8)!)
//        XCTAssertEqual(receivedData?.count, bigDataChunk.count)
//        XCTAssertEqual(data, bigDataChunk)
//        XCTAssertNil(receivedError)
//        XCTAssertEqual(receivedResponse?.statusCode, 200)
//    }
