//
//  JGLoggerProtocol.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

protocol JGLogger {
    var options: [JGLOptions] { get set }
    var logBuilder: JGLogBuilderProtocol? { get set }

    func log(_: Error?, with tag: String?, and options: [JGLOptions])
    func log(_: String..., with tag: String?, and options: [JGLOptions])

    /// Override this method with your own logic regarding when console logging should happen
    /// There is a default implementation and, if you want to use it, create a environment variable
    /// named 'shouldPrintLog' and define its value as true. Now inside the implementation of the log
    /// methods, use shouldPrintConsoleMessages() to define when console logging should happen
    ///
    /// - Returns: true if should log, otherwise false
    func shouldPrintConsoleMessages() -> Bool
}

/// This extension has one purpose:
/// 1. to provide a default implementation of shouldPrintConsoleMessages() method using an environment variable
extension JGLogger {
    func shouldPrintConsoleMessages() -> Bool {
        let shouldPrintLog = ProcessInfo.processInfo.environment["shouldPrintLog"]
        return shouldPrintLog != nil && shouldPrintLog == "true"
    }
}
