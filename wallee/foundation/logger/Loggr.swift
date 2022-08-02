//
//  Loggr.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import Foundation

class Loggr {
    private static var loggings: [Logging] = []

    static func initialize(loggings: [Logging]) {
        self.loggings = loggings
    }

    static func debug(tag: String? = nil, message: () -> Any?) {
        log(tag: tag, priority: .debug, message: message)
    }
    
    static func info(tag: String? = nil, message: () -> Any?) {
        log(tag: tag, priority: .info, message: message)
    }
    
    static func notice(tag: String? = nil, message: () -> Any?) {
        log(tag: tag, priority: .notice, message: message)
    }

    static func error(tag: String? = nil, error: Error? = nil, message: () -> Any?) {
        log(tag: tag, priority: .error, message: message, error: error)
    }

    static func record(tag: String? = nil, error: Error? = nil, message: () -> Any?) {
        log(tag: tag, priority: .fault, message: message, error: error)
    }

    private static func log(
        tag: String?,
        priority: LogLevel,
        message: () -> Any?,
        error: Error? = nil
    ) {
        log(
            tag: tag ?? "Loggr",
            priority: priority,
            message: (message() as? String) ?? "",
            error: error
        )
    }

    private static func log(
        tag: String,
        priority: LogLevel,
        message: String,
        error: Error? = nil
    ) {
        self.loggings.forEach {
            $0.log(tag: tag, priority: priority, message: message, error: error)
        }
    }
}

