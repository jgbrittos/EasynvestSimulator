//
//  JGLoggerProtocol.swift
//  zimcorretor
//
//  Created by João Gabriel on 19/10/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

protocol JGLogger {
    var options: [JGLOptions] { get set }
    var logBuilder: JGLogBuilderProtocol? { get set }
    
    func setup()
//    func log(_: JGNetworkResponse?, with tag: String?, and options: [JGLOptions])
    func log(_: Error?, with tag: String?, and options: [JGLOptions])
    func log(_: String?, with tag: String?, and options: [JGLOptions])
    func log(_: String..., with tag: String?, and options: [JGLOptions])
    
    /// Override this method with your own logic regarding when console logging should happen
    /// There is a default implementation and, if you want to use it, create a environment variable
    /// named 'shouldPrintLog' and define its value as true. Now inside the implementation of the log
    /// methods, use shouldPrintConsoleMessages() to define when console logging should happen
    ///
    /// - Returns: true if should log, otherwise false
    func shouldPrintConsoleMessages() -> Bool
}

/// This extension has two purposes:
/// 1. to provide default values for parameters to whoever uses JGLogger, this way, it is like all methods are
/// optional since there is no need to implement them in the custom class
/// 2. to provide a default implementation of shouldPrintConsoleMessages() method using an environment variable
extension JGLogger {
    func setup() {
        print("No setup method implementation provided")
    }
    
    func log(_ message: String?, with tag: String? = nil, and options: [JGLOptions] = JGLDefaultOptions) {
        print("No log method implementation provided")
    }
    
    func log(_ message: String..., with tag: String? = nil, and options: [JGLOptions] = JGLDefaultOptions) {
        print("No log method implementation provided")
    }
    
    func log(_ error: Error?, with tag: String? = nil, and options: [JGLOptions] = JGLDefaultOptions) {
        print("No log method implementation provided")
    }
    
    func shouldPrintConsoleMessages() -> Bool {
        let shouldPrintLog = ProcessInfo.processInfo.environment["shouldPrintLog"]
        return shouldPrintLog != nil && shouldPrintLog == "true"
    }
}
