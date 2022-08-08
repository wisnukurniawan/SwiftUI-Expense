//
//  TransactionDetailState.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import ComposableArchitecture
import Foundation

// MARK: - State

public struct TransactionDetailState: Equatable {
    var transactionId: UUID? = nil
    var transactionType: TransactionType = .expense
    
    var accounts: [Account] = []
    var selectedAccount: Account = Account.empty
    var selectedTransferAccount: Account? = nil
    
    var category: CategoryType = .others
    var totalAmount: Decimal = Decimal.zero
    var note: String = ""
    var currency: Currency = .defaultValue
    var transactionDate: Date = .init()
    var transactionCreatedAt: Date = .init() // TODO: Don't think UI need this, revisit later
    var transactionUpdatedAt: Date? = nil
    var datePickerShown: Bool = false
}

// MARK: - Action

enum TransactionDetailAction: Equatable {
    case onAppear(UUID?)
    
    case dataLoaded([Account], TransactionWithAccount?)
    
    case save
    case delete
    
    case selectTransactionType(TransactionType)
    
    case totalAmountChange(String)
    case totalAmountFocusChange(Bool)

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
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var accounts: () -> Effect<[Account], Never>
    var transaction: (UUID) -> Effect<TransactionWithAccount, Never>
}

// MARK: - Reducer

let transactionDetailReducer = Reducer<TransactionDetailState, TransactionDetailAction, TransactionDetailEnvironment> { state, action, environment in
    switch action {
    case let .onAppear(transactionId):
        if transactionId == nil {
            return environment.accounts()
                .receive(on: environment.mainQueue)
                .eraseToEffect { accounts in
                    TransactionDetailAction.dataLoaded(accounts, nil)
                }
        } else {
            return environment.transaction(transactionId!)
                .flatMap { transaction in
                    environment.accounts()
                        .map { accounts in
                            (accounts, transaction)
                        }
                }
                .receive(on: environment.mainQueue)
                .eraseToEffect { (accounts, transaction) in
                    TransactionDetailAction.dataLoaded(accounts, transaction)
                }
        }
    case let .dataLoaded(accounts, transaction):
        state.transactionId = transaction?.transaction.id
        state.transactionType = transaction?.transaction.type ?? .expense
        state.category = transaction?.transaction.categoryType ?? .others
        state.note = transaction?.transaction.note ?? ""
        state.totalAmount = transaction?.transaction.amount.asDisplay() ?? Decimal.zero
        state.transactionDate = transaction?.transaction.date ?? environment.date()
        state.transactionCreatedAt = transaction?.transaction.createdAt ?? environment.date()
        state.transactionUpdatedAt = transaction?.transaction.updatedAt
        state.currency = transaction?.transaction.currency ?? accounts.getDefault().currency
        
        state.accounts = accounts
        state.selectedAccount = transaction?.account ?? accounts.getDefault()
        state.selectedTransferAccount = transaction?.transferAccount
        
        return .none
        
    case .save:
        return .none
    case .delete:
        return .none
        
    case let .selectTransactionType(type):
        state.transactionType = type
        return .none

    case let .totalAmountChange(totalAmount):
        state.totalAmount = Decimal(string: totalAmount) ?? Decimal.zero
        return .none
    case .totalAmountFocusChange:
        return .none
        
    case let .changeNote(note):
        state.note = note
        return .none
        
    case let .selectAccount(account):
        state.selectedAccount = account
        state.selectedTransferAccount = state.accounts.select(except: state.selectedAccount)
        return .none
        
    case let .selectTransferAccount(account):
        state.selectedTransferAccount = account
        state.selectedAccount = state.accounts.select(except: state.selectedTransferAccount!)!
        return .none
    
    case .clickDate:
        state.datePickerShown = !state.datePickerShown
        return .none
    case let .selectDate(date):
        state.transactionDate = date
        return .none
        
    case let .selectCategory(category):
        state.category = category
        return .none
    }
}
