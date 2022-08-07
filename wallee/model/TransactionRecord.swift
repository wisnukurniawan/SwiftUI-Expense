//
//  TransactionRecord.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct TransactionRecord {
    var id: UUID
    var transactionId: String
    var amount: Decimal
    var createdAt: Date
}
