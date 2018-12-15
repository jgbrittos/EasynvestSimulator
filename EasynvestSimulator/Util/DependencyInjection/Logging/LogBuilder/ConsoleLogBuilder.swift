//
//  ConsoleLogBuilder.swift
//  zimcorretor
//
//  Created by João Gabriel on 28/09/18.
//  Copyright © 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

class ConsoleLogBuilder: JGLogBuilderProtocol {
    
    // LogBuilderProtocol protocol properties
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
        if let t = tag {
            self.log.append(JGLDefaultConstants.BreakLine)
            self.log.append(t)
        }
        self.log.append(JGLDefaultConstants.BreakLine)
    }
    
    func with(_ options: [JGLOptions]) -> JGLogBuilderProtocol {
        self.hasPrefix = options.contains(.Prefix)
        self.hasSuffix = options.contains(.Suffix)
        self.hasHeader = options.contains(.Header)
        self.hasFooter = options.contains(.Footer)
        
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
        if let h = header { self.defaultHeader = h }
        
        self.log.append(prefix: prefixMarker, if: hasPrefix)
        self.log.append(self.defaultHeader)
        self.log.append(suffix: suffixMarker, if: hasSuffix)
        self.log.append(JGLDefaultConstants.Break2Lines)
        
        return self
    }
    
    func set(_ l: String) -> JGLogBuilderProtocol {
        self.log.append(l)
        self.log.append(JGLDefaultConstants.BreakLine)
        return self
    }
    
    func set(footer: String?) -> JGLogBuilderProtocol {
        guard hasFooter else { return self }
        if let f = footer { self.defaultFooter = f }
        
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
    
    /// Alternative function to include logs at once, instead one by one
    ///
    /// - Parameter logs: all logs
    /// - Returns: LogBuilderProtocol representing builder object filled with logs
    func set(logs: String...) -> JGLogBuilderProtocol {
        for l in logs {
            self.log.append(l)
            self.log.append(JGLDefaultConstants.BreakLine)
        }
        return self
    }
    
    func set(logs: [String]) -> JGLogBuilderProtocol {
        for l in logs {
            self.log.append(l)
            self.log.append(JGLDefaultConstants.BreakLine)
        }
        return self
    }
}
