//
//  Logging.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import Foundation

protocol Logging {
    func log(tag: String, priority: LogLevel, message: String, error: Error?)
}
