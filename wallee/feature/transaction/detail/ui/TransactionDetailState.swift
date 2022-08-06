//
//  TransactionDetailState.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct TransactionDetailState {
    var transactionTypeItems: [TransactionTypeItem] = []
    var accountItems: [AccountItem] = []
    var transferAccountItems: [AccountItem] = []
    var categoryItems: [CategoryItem] = []
    var totalAmount: String = "0"
    var note: String = ""
    var currency: Currency = .defaultValue
    var transactionDate: Date = .init()
    var transactionCreatedAt: Date = .init()
    var transactionUpdatedAt: Date? = nil
    var isEditMode: Bool = false
}

struct AccountItem {
    var account: Account
    var selected: Bool
}

struct TransactionTypeItem {
    var title: String
    var selected: Bool
    var transactionType: TransactionType
}

struct CategoryItem {
    var type: CategoryType
    var selected: Bool
}
