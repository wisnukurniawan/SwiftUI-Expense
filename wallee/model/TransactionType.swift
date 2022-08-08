//
//  TransactionType.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

enum TransactionType: Equatable, CaseIterable, Hashable {
    case expense
    case income
    case transfer
}
