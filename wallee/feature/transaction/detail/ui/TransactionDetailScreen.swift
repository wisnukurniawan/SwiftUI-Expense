//
//  TransactionDetailScreen.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import SwiftUI

struct TransactionDetailScreen: View {
    @ObservedObject private var viewModel = TransactionDetailViewModel()
    
    var body: some View {
        NavigationView {
            List {
                let _ = Loggr.debug {
                    "Wisnukrn"
                }
                let _ = viewModel.state
            }
            .toolbar {
                Button("Save") {
                    viewModel.initLoad()
                }
            }
        }
    }
}
