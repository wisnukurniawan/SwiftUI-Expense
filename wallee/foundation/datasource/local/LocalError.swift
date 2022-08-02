//
//  LocalError.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 02/08/22.
//

import Foundation

enum LocalError: Error {
    case persistentHistoryChangeError
}

extension LocalError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .persistentHistoryChangeError:
            return NSLocalizedString("Failed to execute a persistent history change request.", comment: "")
        }
    }
}

extension LocalError: Identifiable {
    var id: String? {
        errorDescription
    }
}
