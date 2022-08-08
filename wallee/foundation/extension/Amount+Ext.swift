//
//  Amount+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation

let defaultAmountMultiplier: Decimal = 100

extension Decimal {
    func asDisplay() -> Int {
        let size = Decimal(2)
        let test = pow(size, 2) - 1
        let result = NSDecimalNumber(decimal: test)
        return Int(truncating: result)
    }
    
    static var zero = Decimal(0)
}
