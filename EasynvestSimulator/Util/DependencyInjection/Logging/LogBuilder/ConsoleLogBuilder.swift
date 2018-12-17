//
//  ConsoleLogBuilder.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

class ConsoleLogBuilder: JGLogBuilderProtocol {
    var defaultHeader: String = JGLDefaultConstants.Header
    var defaultFooter: String = JGLDefaultConstants.Footer
    var prefixMarker: String = JGLDefaultConstants.Prefix
    var suffixMarker: String = JGLDefaultConstants.Suffix

    var hasPrefix: Bool = true
    var hasSuffix: Bool = true
    var hasHeader: Bool = true
    var hasFooter: Bool = true

    // Class properties
    var log: String = ""

    init(with tag: String? = nil) {
        if let tag = tag {
            self.log.append(JGLDefaultConstants.BreakLine)
            self.log.append(tag)
        }
        self.log.append(JGLDefaultConstants.BreakLine)
    }

    func with(_ options: [JGLOptions]) -> JGLogBuilderProtocol {
        self.hasPrefix = options.contains(.prefix)
        self.hasSuffix = options.contains(.suffix)
        self.hasHeader = options.contains(.header)
        self.hasFooter = options.contains(.footer)

        return self
    }

    func with(prefix: String) -> JGLogBuilderProtocol {
        self.prefixMarker = prefix
        return self
    }

    func with(suffix: String) -> JGLogBuilderProtocol {
        self.suffixMarker = suffix
        return self
    }

    func set(header: String?) -> JGLogBuilderProtocol {
        guard hasHeader else { return self }
        if let header = header { self.defaultHeader = header }

        self.log.append(prefix: prefixMarker, if: hasPrefix)
        self.log.append(self.defaultHeader)
        self.log.append(suffix: suffixMarker, if: hasSuffix)
        self.log.append(JGLDefaultConstants.Break2Lines)

        return self
    }

    func set(_ log: String) -> JGLogBuilderProtocol {
        self.log.append(log)
        self.log.append(JGLDefaultConstants.BreakLine)
        return self
    }

    func set(footer: String?) -> JGLogBuilderProtocol {
        guard hasFooter else { return self }
        if let footer = footer { self.defaultFooter = footer }

        self.log.append(JGLDefaultConstants.BreakLine)
        self.log.append(prefix: prefixMarker, if: hasPrefix)
        self.log.append(self.defaultFooter)
        self.log.append(suffix: suffixMarker, if: hasSuffix)
        self.log.append(JGLDefaultConstants.BreakLine)

        return self
    }

    func build() -> String {
        return self.log
    }

    func set(logs: [String]) -> JGLogBuilderProtocol {
        for log in logs {
            self.log.append(log)
            self.log.append(JGLDefaultConstants.BreakLine)
        }
        return self
    }
}
