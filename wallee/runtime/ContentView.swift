//
//  ContentView.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

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
                    TransactionDetailScreen()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
