//
//  TransactionDetailViewModel.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 08/08/22.
//

import Foundation
import Combine

@MainActor class TransactionDetailViewModel : ObservableObject {
    private let environment: TransactionDetailEnvironment
    private var cancellables = Set<AnyCancellable>()
    private let transactionId: UUID?
    
    @Published private(set) var state: TransactionDetailState = TransactionDetailState.init()
    
    init(
        environment: TransactionDetailEnvironment,
        transactionId: UUID?
    ) {
        self.environment = environment
        self.transactionId = transactionId
        
        initLoad()
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    private func initLoad() {
        if transactionId == nil {
            environment.accounts()
                .receive(on: environment.mainQueue)
                .sink { _ in
                    
                } receiveValue: { [weak self] accounts in
                    self?.dataLoaded(accounts: accounts, transaction: nil)
                }
                .store(in: &cancellables)
        } else {
            environment.transaction(transactionId!)
                .flatMap { transaction in
                    self.environment.accounts()
                        .map { accounts in
                            (accounts, transaction)
                        }
                }
                .receive(on: environment.mainQueue)
                .sink { _ in
                    
                } receiveValue: { [weak self] (accounts, transaction) in
                    self?.dataLoaded(accounts: accounts, transaction: transaction)
                }
                .store(in: &cancellables)
        }
    }
    
    private func dataLoaded(accounts: [Account], transaction: TransactionWithAccount?) {
        state.transactionId = transaction?.transaction.id
        state.transactionType = transaction?.transaction.type ?? .expense
        state.category = transaction?.transaction.categoryType ?? .others
        state.note = transaction?.transaction.note ?? ""
        state.totalAmount = "\(transaction?.transaction.amount ?? 0)"
        state.transactionDate = transaction?.transaction.date ?? environment.date()
        state.transactionCreatedAt = transaction?.transaction.createdAt ?? environment.date()
        state.transactionUpdatedAt = transaction?.transaction.updatedAt
        state.currency = transaction?.transaction.currency ?? accounts.getDefault().currency
        
        state.accounts = accounts
        state.selectedAccount = transaction?.account ?? accounts.getDefault()
        state.selectedTransferAccount = transaction?.transferAccount
    }
    
    func dispatch(action: TransactionDetailAction) {
        switch action {
     
        case .save:
            break
        case .delete:
            break
            
        case let .selectTransactionType(type):
            state.transactionType = type

        case let .totalAmountChange(totalAmount):
            state.totalAmount = totalAmount
            
        case let .changeNote(note):
            state.note = note
            
        case let .selectAccount(account):
            state.selectedAccount = account
            state.selectedTransferAccount = state.accounts.select(except: state.selectedAccount)
            
        case let .selectTransferAccount(account):
            state.selectedTransferAccount = account
            state.selectedAccount = state.accounts.select(except: state.selectedTransferAccount!)!
            
        case .clickDate:
            state.datePickerShown = !state.datePickerShown
            
        case let .selectDate(date):
            state.transactionDate = date
            
        case let .selectCategory(category):
            state.category = category
        }
    }
}
