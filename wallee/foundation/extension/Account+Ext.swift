//
//  Account+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 07/08/22.
//

import Foundation



extension Array where Element == Account {
    func getDefault() -> Account {
        return first (where: { $0.id == Account.defaultId })!
    }
    
    func select(except: Account) -> Account? {
        return first(where: { account in
            account.id != except.id
        })
    }
}

extension Account {
    static let defaultId : UUID = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
    
    static let empty = Account(
        id: defaultId, currency: Currency.defaultValue, amount: Decimal.zero, name: "Cash", type: .cash, createdAt: Date.init(), transactions: []
    )
    
    static let dummy1 = Account(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, currency: Currency.defaultValue, amount: Decimal.zero, name: "Bank", type: .bank, createdAt: Date.init(), transactions: []
    )
    
    static let dummy2 = Account(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, currency: Currency.defaultValue, amount: Decimal.zero, name: "Bank", type: .bank, createdAt: Date.init(), transactions: []
    )
}

