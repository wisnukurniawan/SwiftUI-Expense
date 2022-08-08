//
//  TransactionDetailState.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Combine
import Foundation
import SwiftUI

// MARK: - State

public struct TransactionDetailState: Equatable {
    var transactionId: UUID? = nil
    var transactionType: TransactionType = .expense
    
    var accounts: [Account] = []
    var selectedAccount: Account = .empty
    var selectedTransferAccount: Account? = nil
    
    var category: CategoryType = .others
    var totalAmount: String = "0"
    var note: String = ""
    var currency: Currency = .defaultValue
    var transactionDate: Date = .init()
    var transactionCreatedAt: Date = .init() // TODO: Don't think UI need this, revisit later
    var transactionUpdatedAt: Date? = nil
    var datePickerShown: Bool = false
}

// MARK: - Derived

extension TransactionDetailState {
    func isEditMode() -> Bool {
        return transactionId != nil
    }
    
    func getTitle() -> LocalizedStringKey {
        return getTitle(isEditMode: isEditMode(), transactionType: transactionType)
    }
    
    func getNoteHint() -> LocalizedStringKey {
        return getNoteHint(transactionType: transactionType)
    }
    
    func getAccountTitle() -> LocalizedStringKey {
        return getAccountTitle(transactionType: transactionType)
    }
    
    func shouldShowTransferSection() -> Bool {
        return transactionType == .transfer
    }
    
    func shouldShowCategorySection() -> Bool {
        return transactionType == .expense
    }
    
    func getAccountsUi() -> [Account] {
        if isEditMode(), selectedTransferAccount == nil {
            var accounts = accounts
            accounts.append(Account.dummy1)
            return accounts
        } else {
            return accounts
        }
    }
    
    func getSelectedTransferAccountUi() -> Account? {
        if isEditMode(), selectedTransferAccount == nil {
            return Account.dummy1
        } else {
            return selectedTransferAccount
        }
    }
    
    private func getTitle(isEditMode: Bool, transactionType: TransactionType) -> LocalizedStringKey {
        if isEditMode {
            switch transactionType {
            case .income:
                return LocalizedStringKey("transaction_edit_income")
            case .expense:
                return LocalizedStringKey("transaction_edit_expense")
            case .transfer:
                return LocalizedStringKey("transaction_edit_transfer")
            }
        } else {
            return LocalizedStringKey("transaction_edit_add")
        }
    }

    private func getNoteHint(transactionType: TransactionType) -> LocalizedStringKey {
        switch transactionType {
        case .income:
            return LocalizedStringKey("transaction_edit_note_income_hint")
        case .expense:
            return LocalizedStringKey("transaction_edit_note_expense_hint")
        case .transfer:
            return LocalizedStringKey("transaction_edit_note_transfer_hint")
        }
    }

    func getTransactionTypeTitle(transactionType: TransactionType) -> LocalizedStringKey {
        switch transactionType {
        case .income:
            return LocalizedStringKey("transaction_income")
        case .expense:
            return LocalizedStringKey("transaction_expense")
        case .transfer:
            return LocalizedStringKey("transaction_transfer")
        }
    }

    private func getAccountTitle(transactionType: TransactionType) -> LocalizedStringKey {
        switch transactionType {
        case .transfer:
            return LocalizedStringKey("transaction_edit_account_from")
        default:
            return LocalizedStringKey("transaction_edit_account")
        }
    }
}

// MARK: - Action

enum TransactionDetailAction: Equatable {
    case save
    case delete
    
    case selectTransactionType(TransactionType)
    
    case totalAmountChange(String)

    case selectAccount(Account)
    case selectTransferAccount(Account)
    
    case selectCategory(CategoryType)
    
    case clickDate
    case selectDate(Date)
    
    case changeNote(String)
}

// MARK: - Environment

struct TransactionDetailEnvironment {
    var date: () -> Date
    var mainQueue: DispatchQueue
    var accounts: () -> AnyPublisher<[Account], Never>
    var transaction: (UUID) -> AnyPublisher<TransactionWithAccount, Never>
}
