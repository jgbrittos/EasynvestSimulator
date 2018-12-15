//
//  DependencyInjection.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

//http://basememara.com/swift-protocol-oriented-dependency-injection/
protocol Dependency {
    var consoleLogger: JGLogger { get }
    var network: JGNetwork { get }
}

class CoreDependency: Dependency {
    
    var consoleLogger: JGLogger {
        return ConsoleLoggerDII()
    }
    
    var network: JGNetwork {
        return NetworkDII(logHandler: consoleLogger)
    }
}
