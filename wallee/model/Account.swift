//
//  Account.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct Account {
    var id: UUID
    var currency: Currency
    var amount: Decimal
    var name: String
    var type: AccountType
    var createdAt: Date
    var updatedAt: Date?
    var transactions: [Transaction]
}
