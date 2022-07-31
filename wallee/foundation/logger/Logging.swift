//
//  Logging.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import Foundation

protocol Logging {
    func log(priority: Log, message: String, error: Error?)
}
