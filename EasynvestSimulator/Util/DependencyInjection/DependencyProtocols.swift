//
//  DependencyProtocols.swift
//  zimcorretor
//
//  Created by João Gabriel on 19/10/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
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
