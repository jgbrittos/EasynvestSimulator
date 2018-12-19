//
//  ConsoleReporterDII.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

class ConsoleLoggerDII: JGLogger {
    lazy var options = [JGLOptions]()
    var logBuilder: JGLogBuilderProtocol?

    func log(_ messages: String..., with tag: String? = nil, and options: [JGLOptions] = JGLDefaultOptions) {
        self.options = options
        buildLog(with: tag, and: messages)
    }

    func log(_ error: Error?, with tag: String? = nil, and options: [JGLOptions] = JGLDefaultOptions) {
        self.options = options
        buildLog(with: tag, and: error?.localizedDescription)
    }

    private func buildLog(with tag: String?, and message: String?) {
        guard shouldPrintConsoleMessages() else { return }

        logBuilder = ConsoleLogBuilder(with: tag)
            .with(options)
            .set(header: nil)//default
            .set(message ?? "No message available")
            .set(footer: nil)//default

        print(logBuilder!.build())
    }

    private func buildLog(with tag: String?, and messages: [String]) {
        guard shouldPrintConsoleMessages() else { return }

        logBuilder = ConsoleLogBuilder(with: tag).with(options)

        logBuilder!.set(header: nil)

        logBuilder!.set(logs: messages)

        print(logBuilder!.set(footer: nil).build())
    }
}
