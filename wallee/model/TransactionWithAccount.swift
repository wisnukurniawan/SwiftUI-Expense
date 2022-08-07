//
//  TransactionWithAccount.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct TransactionWithAccount: Equatable {
    var transaction: Transaction
    var account: Account
    var transferAccount: Account? = nil
}
