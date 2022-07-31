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

    static func debug(message: () -> Any?) {
        log(priority: .debug, message: message)
    }
    
    static func info(message: () -> Any?) {
        log(priority: .info, message: message)
    }
    
    static func notice(message: () -> Any?) {
        log(priority: .notice, message: message)
    }

    static func error(error: Error? = nil, message: () -> Any?) {
        log(priority: .error, message: message, error: error)
    }

    static func record(error: Error? = nil, message: () -> Any?) {
        log(priority: .fault, message: message, error: error)
    }

    private static func log(
        priority: Log,
        message: () -> Any?,
        error: Error? = nil
    ) {
        log(
            priority: priority,
            message: (message() as? String) ?? "",
            error: error
        )
    }

    private static func log(
        priority: Log,
        message: String,
        error: Error? = nil
    ) {
        self.loggings.forEach {
            $0.log(priority: priority, message: message, error: error)
        }
    }
}

