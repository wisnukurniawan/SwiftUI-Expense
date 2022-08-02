//
//  LoggrInitializer.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 03/08/22.
//

import Foundation
import UIKit
import os

class LoggrInitializer: Initializer {

    func create(application: UIApplication) -> Bool {
        #if DEBUG
        let loggings: [Logging] = [DebugLogging()]
        #else
        let loggings: [Logging] = []
        #endif

        Loggr.initialize(loggings: loggings)

        return true
    }
}

class DebugLogging: Logging {
    private let logger = Logger(subsystem: "com.wisnu.kurniawan", category: "Debug")

    func log(tag: String, priority: LogLevel, message: String, error: Error?) {
        switch priority {
        case .debug:
            logger.debug("\(tag) - \(message)")
        case .info:
            logger.info("\(tag) - \(message)")
        case .notice:
            logger.notice("\(tag) - \(message)")
        case .error:
            logger.error("\(tag) - \(message), error: \(error?.localizedDescription ?? "")")
        case .fault:
            logger.fault("\(tag) - \(message), error: \(error?.localizedDescription ?? "")")
        }
    }
}
