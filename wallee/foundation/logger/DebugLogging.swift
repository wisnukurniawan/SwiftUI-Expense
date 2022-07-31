//
//  DebugLogging.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import Foundation
import os

class DebugLogging : Logging {
    
    private  let logger = Logger(subsystem: "com.wisnu.kurniawan", category: "Debug")
    
     func  log(priority: Log, message: String, error: Error?) {
        switch (priority) {
        case .debug:
            logger.debug("\(message)")
        case .info:
            logger.info("\(message)")
        case .notice:
            logger.notice("\(message)")
        case .error:
            logger.error("\(message), error: \(error?.localizedDescription ?? "")")
        case .fault:
            logger.fault("\(message), error: \(error?.localizedDescription ?? "")")
        }
    }
}

