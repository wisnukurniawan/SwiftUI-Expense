//
//  TransactionDetailScreen.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Combine
import SwiftUI

struct TransactionDetailScreen: View {
    @StateObject private var viewModel: TransactionDetailViewModel = .init(
        environment: TransactionDetailEnvironment(
            date: Date.init,
            mainQueue: .main,
            accounts: {
                Just(
                    [Account.empty, Account.dummy2]
                ).eraseToAnyPublisher()
            },
            transaction: { _ in
                Just(
                    TransactionWithAccount(
                        transaction: Transaction(
                            id: UUID(), currency: Currency.defaultValue, categoryType: .uncategorized, amount: Decimal(9999925), type: .transfer, date: Date(), createdAt: Date(), note: ""
                        ),
                        account: Account.empty,
                        transferAccount: Account.dummy2
                    )
                ).eraseToAnyPublisher()
            }
        ),
        transactionId: nil // Account.defaultId
    )
    
    var body: some View {
        NavigationView {
            Form {
                // Amount section
                Section {
                    TextField(
                        "0",
                        text: Binding<String>(
                            get: { viewModel.state.totalAmount },
                            set: { viewModel.dispatch(action: TransactionDetailAction.totalAmountChange($0)) }
                        )
                    )
                    .keyboardType(.numberPad)
                } header: {
                    if viewModel.state.isEditMode {
                        Text(LocalizedStringKey("transaction_edit_total"))
                    } else {
                        VStack(alignment: .leading, spacing: 34) {
                            Picker(
                                "Transaction type",
                                selection: Binding<TransactionType>(
                                    get: { viewModel.state.transactionType },
                                    set: { transactionType in
                                        withAnimation {
                                            viewModel.dispatch(action: TransactionDetailAction.selectTransactionType(transactionType))
                                        }
                                    }
                                )
                            ) {
                                ForEach(TransactionType.allCases, id: \.self) { item in
                                    Text(viewModel.state.getTransactionTypeTitle(transactionType: item)).tag(item)
                                }
                            }
                            .pickerStyle(.segmented)
                            .textCase(nil)
                            .padding([.top], 6)
                            
                            Text(LocalizedStringKey("transaction_edit_total"))
                                .padding([.leading], 20)
                                .padding([.bottom], 6)
                        }.listRowInsets(EdgeInsets())
                    }
                }
                
                // General section
                Section {
                    Picker(
                        viewModel.state.accountTitle,
                        selection: Binding<Account>(
                            get: { viewModel.state.selectedAccount },
                            set: { viewModel.dispatch(action: TransactionDetailAction.selectAccount($0)) }
                        )
                    ) {
                        ForEach(viewModel.state.accounts, id: \.self) { item in
                            Text(item.name).tag(item)
                        }
                    }
                    
                    if viewModel.state.shouldShowTransferSection {
                        if viewModel.state.selectedTransferAccountUi == nil {
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
                            Picker(
                                LocalizedStringKey("transaction_edit_account_to"),
                                selection: Binding<Account>(
                                    get: { viewModel.state.selectedTransferAccountUi! },
                                    set: { viewModel.dispatch(action: TransactionDetailAction.selectTransferAccount($0)) }
                                )
                            ) {
                                ForEach(viewModel.state.transfereAccounts, id: \.self) { item in
                                    if item.id == Account.dummy1.id {
                                        Text(LocalizedStringKey("transaction_account_deleted")).tag(item)
                                    } else {
                                        Text(item.name).tag(item)
                                    }
                                }
                            }
                            .disabled(viewModel.state.isEditMode)
                        }
                    }
                    
                    // Category section
                    if viewModel.state.shouldShowCategorySection {
                        Picker(
                            LocalizedStringKey("category"),
                            selection: Binding<CategoryType>(
                                get: { viewModel.state.category },
                                set: { viewModel.dispatch(action: TransactionDetailAction.selectCategory($0)) }
                            )
                        ) {
                            ForEach(CategoryType.allCases, id: \.self) { item in
                                let (emoji, text) = item.getEmojiAndText()
                                HStack(spacing: 4) {
                                    Text(LocalizedStringKey(text))
                                    Text(emoji)
                                }.tag(item)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(LocalizedStringKey("transaction_edit_date_transaction"))
                        Button(getStringFromDate(withFormat: "EEE, dd MMM yyyy", date: viewModel.state.transactionDate)) {
                            withAnimation {
                                viewModel.dispatch(action: TransactionDetailAction.clickDate)
                            }
                            
                        }.font(.caption)
                    }
                    
                    if viewModel.state.datePickerShown {
                        DatePicker(
                            "Transaction date",
                            selection: Binding<Date>(
                                get: { viewModel.state.transactionDate },
                                set: { viewModel.dispatch(action: TransactionDetailAction.selectDate($0)) }
                            ),
                            in: datePickerRange,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                    }
                } header: {
                    Text(LocalizedStringKey("transaction_edit_general"))
                }
                
                // Note section
                Section {
                    TextField(
                        viewModel.state.notePlaceholder,
                        text: Binding<String>(
                            get: { viewModel.state.note },
                            set: { viewModel.dispatch(action: TransactionDetailAction.changeNote($0)) }
                        )
                    )
                } header: {
                    Text(LocalizedStringKey("transaction_edit_note"))
                }
                
                // Delete section
                if viewModel.state.isEditMode {
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
                    Text(viewModel.state.toolbarTitle).font(.headline)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey("transaction_edit_cancel")) {
                        // isPresented = false
                        // TODO: dismiss
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    // TODO: save button validation, save content
                    Button(LocalizedStringKey("transaction_edit_save")) {}.font(.headline)
                }
            }
        }
    }
}
