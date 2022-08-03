//
//  LoggrInitializer.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 03/08/22.
//

import Firebase
import Foundation
import os
import UIKit

class LoggrInitializer: Initializer {
    func create(application: UIApplication) -> Bool {
        #if DEBUG
        var loggings: [Logging] = [DebugLogging()]
        #else
        var loggings: [Logging] = []
        #endif
        
        loggings.append(CrashLogging())

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

class CrashLogging: Logging {
    func log(tag: String, priority: LogLevel, message: String, error: Error?) {
        if priority == .fault {
            Crashlytics.crashlytics().log(message)
            if let err = error {
                Crashlytics.crashlytics().record(error: err)
            }
        }
    }
}
