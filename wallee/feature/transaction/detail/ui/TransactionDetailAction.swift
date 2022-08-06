//
//  TransactionDetailAction.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

enum TransactionAction {
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
