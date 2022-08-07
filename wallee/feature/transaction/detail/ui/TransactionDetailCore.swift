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
    var transactionTypeItems: [TransactionTypeItem] = []
    var accountItems: [AccountItem] = []
    var transferAccountItems: [AccountItem] = []
    var categoryItems: [CategoryItem] = []
    var totalAmount: Decimal = Decimal.zero
    var note: String = ""
    var currency: Currency = .defaultValue
    var transactionDate: Date = .init()
    var transactionCreatedAt: Date = .init() // TODO: Don't think UI need this, revisit later
    var transactionUpdatedAt: Date? = nil
}

struct AccountItem: Equatable {
    var account: Account
    var selected: Bool
}

struct TransactionTypeItem: Equatable {
    var title: String
    var selected: Bool
    var transactionType: TransactionType
}

struct CategoryItem: Equatable {
    var type: CategoryType
    var selected: Bool
}

// MARK: - Action

enum TransactionDetailAction: Equatable {
    case onAppear(UUID?)
    
    case dataLoaded([Account], TransactionWithAccount?)
    
    case save
    case delete
    
    case selectTransactionType(TransactionTypeItem)
    
    case totalAmountChange(String)
    case totalAmountFocusChange(Bool)
    
    case changeNote(String)
    case clickAccount
    case clickTransferAccount
    case selectDate(Date)
    case clickCategory
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
        state.transactionTypeItems = initialTransactionTypes(selectedType: transaction?.transaction.type ?? .expense)
        state.categoryItems = initialCategoryTypes(selectedCategoryType: transaction?.transaction.categoryType ?? .others)
        state.note = transaction?.transaction.note ?? ""
        state.totalAmount = transaction?.transaction.amount.asDisplay() ?? Decimal.zero
        state.transactionDate = transaction?.transaction.date ?? environment.date()
        state.transactionCreatedAt = transaction?.transaction.createdAt ?? environment.date()
        state.transactionUpdatedAt = transaction?.transaction.updatedAt
        state.currency = transaction?.transaction.currency ?? accounts.getDefaultAccount().currency
        state.accountItems = accounts.toAccountItems(selectedAccount: transaction?.account ?? state.accountItems.selected()?.account, defaultSelectedIndex: 0)
        state.transferAccountItems = accounts.toAccountItems(selectedAccount: transaction?.transferAccount ?? state.transferAccountItems.selected()?.account, defaultSelectedIndex: 1)
        return .none
        
    case .save:
        return .none
    case .delete:
        return .none
        
    case .selectTransactionType:
        return .none
        
    case .totalAmountChange:
        return .none
    case .totalAmountFocusChange:
        return .none
        
    case .changeNote:
        return .none
    case .clickAccount:
        return .none
    case .clickTransferAccount:
        return .none
    case .selectDate:
        return .none
    case .clickCategory:
        return .none
    }
}

// MARK: - Calculation

private func initialTransactionTypes(selectedType: TransactionType = .expense) -> [TransactionTypeItem] {
    return [
        TransactionTypeItem(title: "transaction_expense", selected: false, transactionType: .expense),
        TransactionTypeItem(title: "transaction_income", selected: false, transactionType: .income),
        TransactionTypeItem(title: "transaction_transfer", selected: false, transactionType: .transfer),
    ].map { transactionTypeItem in
        var modify = transactionTypeItem
        modify.selected = transactionTypeItem.transactionType == selectedType
        return modify
    }
}

private func initialCategoryTypes(selectedCategoryType: CategoryType = .others) -> [CategoryItem] {
    return [
        .monthlyFee,
        .adminFee,
        .pets,
        .donation,
        .education,
        .financial,
        .entertainment,
        .childrenNeeds,
        .householdNeeds,
        .sport,
        .others,
        .food,
        .parking,
        .fuel,
        .movie,
        .automotive,
        .tax,
        .income,
        .businessExpense,
        .selfCare,
        .loan,
        .service,
        .shopping,
        .bills,
        .taxi,
        .cashWithdrawal,
        .phone,
        .topUp,
        .publicTransportation,
        .travel,
        .uncategorized,
    ].map { item in
        CategoryItem(
            type: item,
            selected: item == selectedCategoryType
        )
    }
}

private func defaultSelectedAccount(
       selectedAccount: Account?,
       account: Account,
       itemIndex: Int,
       index: Int
) -> Bool {
    if (selectedAccount != nil) {
        return account.id.uuidString == selectedAccount?.id.uuidString ?? ""
   } else {
       return itemIndex == index
   }
}


extension Array where Element == AccountItem {
    func selected() -> AccountItem? {
        return first(where: { element in
            element.selected
        })
    }
}

extension Array where Element == Account {
    func toAccountItems(selectedAccount: Account?, defaultSelectedIndex: Int) -> [AccountItem] {
        return enumerated()
            .map(
                { (index, element) in
                    let defaultSelectedAccount = defaultSelectedAccount(
                        selectedAccount: selectedAccount,
                        account: element,
                        itemIndex: index,
                        index: defaultSelectedIndex
                    )
                    return AccountItem(
                        account: element,
                        selected: defaultSelectedAccount
                    )
                }
            )
    }
}
