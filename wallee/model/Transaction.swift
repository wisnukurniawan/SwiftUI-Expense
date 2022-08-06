//
//  Transaction.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct Transaction {
    var id: String
    var currency: Currency
    var categoryType: CategoryType
    var amount: Decimal
    var type: TransactionType
    var date: Date
    var createdAt: Date
    var updatedAt: Date?
    var note: String
}
