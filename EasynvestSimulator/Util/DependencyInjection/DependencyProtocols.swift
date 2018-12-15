//
//  DependencyProtocols.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import UIKit
import Foundation

private struct DependencyInjector {
    static var dependencies: Dependency = CoreDependency()
    private init() {}
}

protocol NetworkDependency {
    var network: JGNetwork { get }
}
extension NetworkDependency {
    var network: JGNetwork {
        return DependencyInjector.dependencies.network
    }
}

protocol ConsoleLogDependency {
    var logger: JGLogger { get }
}
extension ConsoleLogDependency {
    var logger: JGLogger {
        return DependencyInjector.dependencies.consoleLogger
    }
}

extension UIApplicationDelegate {
    //This method sets up the Dependency Injector singleton
    //at application begining at application(_:willFinishLaunchingWithOptions:)
    //with a new instance of a Dependency container

    func configure(dependency: Dependency) {
        DependencyInjector.dependencies = dependency
    }
}
