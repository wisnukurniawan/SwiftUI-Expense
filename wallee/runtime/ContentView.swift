//
//  ContentView.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import ComposableArchitecture
import CoreData
import SwiftUI

struct ContentView: View {
    // TODO
    // insert transaction into an account
    // show an account with transaction list
    // Create UI first
    
    @State private var showingTransactionDetail = false
    
    var body: some View {
        NavigationView {
            Text("Content")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingTransactionDetail.toggle()
                        } label: {
                            Label("Add Transaction", systemImage: "plus")
                        }
                    }
                }
                .popover(isPresented: $showingTransactionDetail) {
                    TransactionDetailScreen(
                        store: Store(
                            initialState: TransactionDetailState(),
                            reducer: transactionDetailReducer.debug(),
                            environment: TransactionDetailEnvironment(
                              date: Date.init,
                              mainQueue: .main,
                              accounts: {
                                  Effect(
                                    value: [
                                        Account.empty
                                    ]
                                  )
                              },
                              transaction: { _ in
                                  Effect(
                                    value: TransactionWithAccount(
                                        transaction: Transaction(
                                            id: UUID(), currency: Currency.defaultValue, categoryType: .uncategorized, amount: Decimal.zero, type: .transfer, date: Date(), createdAt: Date(), note: ""
                                        ),
                                        account: Account.empty,
                                        transferAccount: Account.dummy2
                                    )
                                  )
                              }
                            )
                          ),
                        transactionId: nil // Account.defaultId
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
