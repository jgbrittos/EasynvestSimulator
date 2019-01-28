//
//  MockWebServer.swift
//  EasynvestSimulatorTests
//
//  Created by João Gabriel de Britto e Silva on 28/01/19.
//  Copyright © 2019 João Gabriel de Britto e Silva. All rights reserved.
//

import Embassy

let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
let htons  = isLittleEndian ? _OSSwapInt16 : { $0 }
let ntohs  = isLittleEndian ? _OSSwapInt16 : { $0 }
let bind = Darwin.bind
let random = Darwin.arc4random
let randomUniform = Darwin.arc4random_uniform
typealias MWSResponse = (Data?, HTTPURLResponse?, Error?) -> Void
typealias StartResponse = ((String, [(String, String)]) -> Void)
typealias SendBody = ((Data) -> Void)
typealias AnyParameter = [String: Any]
//TODO: VER SE DA PRA ENCAIXAR ALGO EM PROTOCOLOS
//enum MWSHTTPStatus: Int {
//    case ok = 200
//    case unauthorized = 401
//    case notFound = 404
//    case internalError = 500
//}
//
//protocol MWSResponses {
//    func success()
//    func error(_ error: MWSHTTPStatus)
//}

class MockWebServer {
    let queue = DispatchQueue(label: "br.com.easynvest.mock.http-server", attributes: [])
    var loop: SelectorEventLoop!
    var session: URLSession!
    var port: Int = 8080
    
    init(timeout: UInt64 = 30) {
        loop = try! SelectorEventLoop(selector: try! KqueueSelector())
        session = URLSession(configuration: .default)
        
        queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(timeout * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            if self.loop.running {
                self.loop.stop()
                //TODO: usar throws com custom error TIME_OUT em vez de print
                print("Ops...Time out after \(timeout) seconds")
            }
        }
        port = try! getUnusedTCPPort()
    }
    
    func withResponse(_ name: String, serverResponds: @escaping MWSResponse) {
        let data = getMockDataFromJson(named: name)
        
        let server = DefaultHTTPServer(eventLoop: loop, port: port) { (
            environ: AnyParameter,
            startResponse: StartResponse,
            sendBody: SendBody
            ) in
            startResponse("200 OK", [])
            sendBody(data)
            sendBody(Data())
        }
        
        try! server.start()
        
        var receivedData: Data?
        var receivedResponse: HTTPURLResponse?
        var receivedError: Error?
        queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            let task = self.session.dataTask(with: URL(string: "http://[::1]:\(self.port)")!,
                                             completionHandler: { (data, response, error) in
                                                receivedData = data
                                                receivedResponse = response as? HTTPURLResponse
                                                receivedError = error
                                                self.loop.stop()
                                                serverResponds(receivedData ?? Data(), receivedResponse, receivedError)
            })
            task.resume()
        }
        
        loop.runForever()
        
//        queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
//            let task = self.session.dataTask(with: URL(string: "http://[::1]:\(self.port)")!, completionHandler: { (data, response, error) in
//                self.loop.stop()
//                serverResponds(data, response as? HTTPURLResponse, error)
//            })
//            task.resume()
//        }
//
//        loop.runForever()
    }
}

//MARK: - Helper methods
extension MockWebServer {
    
    func getMockDataFromJson(named: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: named, withExtension: "json") else {
            return Data()
        }
        
        return try! Data(contentsOf: url)
    }
    
    /// Find an available localhost TCP port from 1024-65535 and return it.
    /// Ref: https://github.com/pytest-dev/pytest-asyncio/blob/412c63776b32229ed8320e6c7ea920d7498cd695/pytest_asyncio/plugin.py#L103-L107
    func getUnusedTCPPort() throws -> Int {
        var interfaceAddress: in_addr = in_addr()
        guard "127.0.0.1".withCString({ inet_pton(AF_INET, $0, &interfaceAddress) >= 0 }) else {
            throw OSError.lastIOError()
        }
        
        let socketType = SOCK_STREAM
        let fileDescriptor = socket(AF_INET, socketType, 0)
        guard fileDescriptor >= 0 else { throw OSError.lastIOError() }
        defer {
            close(fileDescriptor)
        }
        
        var address = sockaddr_in()
        address.sin_family = sa_family_t(AF_INET)
        address.sin_port = htons(UInt16(0))
        address.sin_addr = interfaceAddress
        address.sin_zero = (0, 0, 0, 0, 0, 0, 0, 0)
        let addressSize = socklen_t(MemoryLayout<sockaddr_in>.size)
        // given port 0, and bind, it will find us an available port
        guard withUnsafePointer(to: &address, { pointer in
            return pointer.withMemoryRebound(
                to: sockaddr.self,
                capacity: Int(addressSize)
            ) { pointer in
                return bind(fileDescriptor, pointer, addressSize) >= 0
            }
        }) else {
            throw OSError.lastIOError()
        }
        
        var socketAddress = sockaddr_in()
        var socketAddressSize = socklen_t(MemoryLayout<sockaddr_in>.size)
        guard withUnsafeMutablePointer(to: &socketAddress, { pointer in
            return pointer.withMemoryRebound(
                to: sockaddr.self,
                capacity: Int(socketAddressSize)
            ) { pointer in
                return getsockname(fileDescriptor, pointer, &socketAddressSize) >= 0
            }
        }) else {
            throw OSError.lastIOError()
        }
        return Int(ntohs(socketAddress.sin_port))
    }
}

//TODO: Replace with mine custom error
public enum OSError: Error {
    case ioError(number: Int32, message: String)
    /// Return a socket error with the last error number and description
    static func lastIOError() -> OSError {
        return .ioError(number: errno, message: lastErrorDescription())
    }
}

/// Return description for last error
func lastErrorDescription() -> String {
    return String(cString: UnsafePointer(strerror(errno)))
}
