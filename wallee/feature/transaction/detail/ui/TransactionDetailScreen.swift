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
        
        init(state: TransactionDetailState) {
            self.isEditMode = state.transactionId != nil
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
                    Section {
                        Text("TOTAL")
                    } header: {
                        Text("TOTAL")
                    }
                    
                    Section {
                        Text("1")
                        HStack {
                            Text("Name")
                            Spacer()
                            Text("iPhone 11")
                        }
                    } header: {
                        Text("GENERAL")
                    }
                    
                    Section {
                        Text("NOTE (OPTIONAL)")
                    } header: {
                        Text("NOTE (OPTIONAL)")
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Title").font(.headline)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            //isPresented = false
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {}.font(.headline)
                    }
                }
            }
            .onAppear {
                viewStore.send(TransactionDetailAction.onAppear(transactionId))
            }
        }
    }
}
