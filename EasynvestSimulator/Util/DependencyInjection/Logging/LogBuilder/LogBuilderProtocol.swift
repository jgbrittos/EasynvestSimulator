//
//  LogBuilderProtocol.swift
//  EasynvestSimulator
//
//  Created by João Gabriel on 14/12/18.
//  Copyright (c) 2018 João Gabriel de Britto e Silva. All rights reserved.
//

import Foundation

let JGLDefaultOptions: [JGLOptions] = [.prefix, .suffix, .header, .footer]

enum JGLOptions {
    case header
    case footer
    case prefix
    case suffix
}

struct JGLDefaultConstants {
    static let Header = "Start Logging in Console"
    static let Footer = "Ending Logging in Console"
    static let Prefix = "########################################~~~ "
    static let Suffix = " ~~~########################################"
    static let BreakLine = "\n"
    static let Break2Lines = "\n\n"
}

protocol JGLogBuilderProtocol {
    var prefixMarker: String { get set }
    var suffixMarker: String { get set }

    var defaultHeader: String { get set }
    var defaultFooter: String { get set }

    var hasPrefix: Bool { get set }
    var hasSuffix: Bool { get set }
    var hasHeader: Bool { get set }
    var hasFooter: Bool { get set }

    var log: String { get set }

    @discardableResult
    func set(header: String?) -> JGLogBuilderProtocol
    @discardableResult
    func set(_: String) -> JGLogBuilderProtocol
    @discardableResult
    func set(logs: String...) -> JGLogBuilderProtocol
    @discardableResult
    func set(logs: [String]) -> JGLogBuilderProtocol
    @discardableResult
    func set(footer: String?) -> JGLogBuilderProtocol
    @discardableResult
    func with(_ options: [JGLOptions]) -> JGLogBuilderProtocol
    @discardableResult
    func with(prefix: String) -> JGLogBuilderProtocol
    @discardableResult
    func with(suffix: String) -> JGLogBuilderProtocol

    func build() -> String
}

extension String {
    mutating func append(prefix: String, if hasPrefix: Bool) {
        if hasPrefix {
            self.append(prefix)
        }
    }

    mutating func append(suffix: String, if hasSuffix: Bool) {
        if hasSuffix {
            self.append(suffix)
        }
    }
}

extension Dictionary {
    var toJson: String {
        do {
            let json = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)

            if let jsonString = String(data: json, encoding: .utf8) {
                return jsonString
            } else {
                return "Error printing data as JSON"
            }
        } catch {
            return "Error printing data as JSON"
        }
    }

    func merge(with dictionary: [Key: Value]) -> [Key: Value] {
        var mergedDict: [Key: Value] = [:]

        [self, dictionary].forEach { dict in
            for (key, value) in dict {
                mergedDict[key] = value
            }
        }

        return mergedDict
    }
}

extension Data {
    var toJson: String {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])
            let jsonResponse = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

            if let jsonString = String(data: jsonResponse, encoding: .utf8) {
                return jsonString
            } else {
                return "Error printing data as JSON"
            }
        } catch {
            return "Error printing data as JSON"
        }
    }
}
