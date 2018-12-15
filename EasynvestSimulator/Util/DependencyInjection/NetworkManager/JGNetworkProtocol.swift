//
//  JGNetworkProtocol.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

typealias AnyParameters = [String: Any]
typealias JGNetworkCompletionSuccess = (_ response: Data) -> Void
typealias JGNetworkCompletionFailure = (_ message: String) -> Void

protocol JGNetwork {
    var logger: JGLogger { get }

    func getRequest(for url: String,
                    with parameters: AnyParameters,
                    success: @escaping JGNetworkCompletionSuccess,
                    failure: @escaping JGNetworkCompletionFailure)
}
