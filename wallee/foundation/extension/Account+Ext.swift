//
//  Account+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation

extension Array where Element == Account {
    func getDefaultAccount() -> Account {
        return first (where: { $0.id == defaultAccountId })!
    }
}
