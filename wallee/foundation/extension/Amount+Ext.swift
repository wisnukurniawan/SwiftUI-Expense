//
//  Amount+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation

let defaultAmountMultiplier: Decimal = 100

extension Decimal {
    func asDisplay() -> Decimal {
        var calculated = self / defaultAmountMultiplier
        var rounded = Decimal()
        NSDecimalRound(&rounded, &calculated, 2, .bankers)
        return rounded
    }
    
    static var zero = Decimal(0)
}
