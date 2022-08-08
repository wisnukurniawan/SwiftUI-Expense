//
//  TransactionDetailScreen.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import ComposableArchitecture
import SwiftUI

struct TransactionDetailScreen: View {
    
    let store: Store<TransactionDetailState, TransactionDetailAction>
    let transactionId: UUID?
    
    struct ViewState: Equatable {
        var isEditMode: Bool
        var transactionType: TransactionType
        var title: LocalizedStringKey
        var noteHint: LocalizedStringKey
        var accountTitle: LocalizedStringKey
        var totalAmount: String
        var note: String
        var accounts: [Account]
        var selectedAccount: Account
        var selectedTransferAccount: Account?
        var shouldShowTransferSection: Bool
        var category: CategoryType
        var shouldShowCategorySection: Bool
        var datePickerShown: Bool
        var transactionDate: Date
        
        init(state: TransactionDetailState) {
            self.isEditMode = state.transactionId != nil
            self.transactionType = state.transactionType
            self.title = getTitle(isEditMode: self.isEditMode, transactionType: state.transactionType)
            self.noteHint = getNoteHint(transactionType: state.transactionType)
            self.totalAmount = "\(state.totalAmount)"
            self.note = state.note
            self.accountTitle = getAccountTitle(transactionType: state.transactionType)
            
            self.accounts = state.accounts
            self.selectedAccount = state.selectedAccount
            self.selectedTransferAccount = state.selectedTransferAccount
            if isEditMode && state.selectedTransferAccount == nil {
                self.accounts.append(Account.dummy1)
                self.selectedTransferAccount = Account.dummy1
            }
            
            self.shouldShowTransferSection = state.transactionType == .transfer
            self.shouldShowCategorySection = state.transactionType == .expense
            
            self.category = state.category
            
            self.datePickerShown = state.datePickerShown
            self.transactionDate = state.transactionDate
        }
    }
    
    public init(
        store: Store<TransactionDetailState, TransactionDetailAction>,
        transactionId: UUID?
    ) {
        self.store = store
        self.transactionId = transactionId
    }
    
    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init)) { viewStore in
            NavigationView {
                Form {
                    // Amount section
                    Section {
                        // TODO: currency prefix, text color based on type, formatting
                        TextField("0", text: viewStore.binding(get: \.totalAmount, send: TransactionDetailAction.totalAmountChange))
                            .keyboardType(.numberPad)
                    } header: {
                        Text(LocalizedStringKey("transaction_edit_total"))
                    }
                    
                    // General section
                    Section {
                        Picker(viewStore.accountTitle, selection: viewStore.binding(get: \.selectedAccount, send: TransactionDetailAction.selectAccount)) {
                            ForEach(viewStore.accounts, id: \.self) { item in
                                Text(item.name).tag(item)
                            }
                        }.disabled(viewStore.isEditMode)
                        
                        if viewStore.shouldShowTransferSection {
                            if viewStore.selectedTransferAccount == nil {
                                HStack {
                                    Text(LocalizedStringKey("transaction_edit_account_to"))
                                    Spacer()
                                    Button(action: {
                                        // TODO: open create new account
                                    }) {
                                        Text(LocalizedStringKey("transaction_edit_account_to_create_transfer_account"))
                                    }
                                }
                                
                            } else {
                                Picker(LocalizedStringKey("transaction_edit_account_to"), selection: viewStore.binding(get: \.selectedTransferAccount!, send: TransactionDetailAction.selectTransferAccount)) {
                                    ForEach(viewStore.accounts, id: \.self) { item in
                                        if item.id == Account.dummy1.id {
                                            Text(LocalizedStringKey("transaction_account_deleted")).tag(item)
                                        } else {
                                            Text(item.name).tag(item)
                                        }
                                    }
                                }.disabled(viewStore.isEditMode)
                            }
                        }
                        
                        if viewStore.shouldShowCategorySection {
                            Picker(LocalizedStringKey("category"), selection: viewStore.binding(get: \.category, send: TransactionDetailAction.selectCategory)) {
                                ForEach(CategoryType.allCases, id: \.self) { item in
                                    let (emoji, text) = item.getEmojiAndText()
                                    HStack {
                                        Text(LocalizedStringKey(text))
                                        Spacer().frame(width: 4)
                                        Text(emoji)
                                    }.tag(item)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(LocalizedStringKey("transaction_edit_date_transaction"))
                            Button(getStringFromDate(withFormat: "EEE, dd MMM yyyy", date: viewStore.transactionDate)) {
                                viewStore.send(TransactionDetailAction.clickDate)
                            }.font(.caption)
                        }
                        
                        if viewStore.datePickerShown {
                            DatePicker("Transaction date", selection: viewStore.binding(get: \.transactionDate, send: TransactionDetailAction.selectDate), in: datePickerRange, displayedComponents: [.date]).datePickerStyle(.graphical)
                        }
                    } header: {
                        Text(LocalizedStringKey("transaction_edit_general"))
                    }
                    
                    // Note section
                    Section {
                        TextField(viewStore.noteHint, text: viewStore.binding(get: \.note, send: TransactionDetailAction.changeNote))
                    } header: {
                        Text(LocalizedStringKey("transaction_edit_note"))
                    }
                    
                    // Delete section
                    if viewStore.isEditMode {
                        HStack {
                            Spacer()
                            Button(role: .destructive, action: {
                                // TODO: delete transaction button
                            }) {
                                Text(LocalizedStringKey("transaction_edit_delete"))
                            }
                            Spacer()
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        if viewStore.isEditMode {
                            Text(viewStore.title).font(.headline)
                        } else {
                            Picker("Transaction type", selection: viewStore.binding(get: \.transactionType, send: TransactionDetailAction.selectTransactionType).animation()) {
                                ForEach(TransactionType.allCases, id: \.self) { item in
                                    Text(getTransactionTypeTitle(transactionType: item)).tag(item)
                                }
                            }.pickerStyle(.segmented).fixedSize()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button(LocalizedStringKey("transaction_edit_cancel")) {
                            // isPresented = false
                            // TODO: dismiss
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        // TODO: save button validation, save content
                        Button(LocalizedStringKey("transaction_edit_save")) {
                            
                        }.font(.headline)
                    }
                }
            }
            .onAppear {
                viewStore.send(TransactionDetailAction.onAppear(transactionId))
            }
        }
    }
}

// MARK: - Calculation

private func getTitle(isEditMode: Bool, transactionType: TransactionType) -> LocalizedStringKey {
    if (isEditMode) {
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

private func getTransactionTypeTitle(transactionType: TransactionType) -> LocalizedStringKey {
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
