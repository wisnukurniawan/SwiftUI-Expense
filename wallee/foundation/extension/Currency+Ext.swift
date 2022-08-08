//
//  Currency+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation

let zeroAmount = "0"

func getAmountNumberFormatter() -> NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .currency
    numberFormatter.maximumFractionDigits = 2
    return numberFormatter
}
