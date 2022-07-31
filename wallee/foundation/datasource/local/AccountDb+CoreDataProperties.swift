//
//  AccountDb+CoreDataProperties.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//
//

import Foundation
import CoreData


extension AccountDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountDb> {
        return NSFetchRequest<AccountDb>(entityName: "AccountDb")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var currencyCode: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var amount: Int64
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var accountRecords: NSSet?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for accountRecords
extension AccountDb {

    @objc(addAccountRecordsObject:)
    @NSManaged public func addToAccountRecords(_ value: AccountRecordDb)

    @objc(removeAccountRecordsObject:)
    @NSManaged public func removeFromAccountRecords(_ value: AccountRecordDb)

    @objc(addAccountRecords:)
    @NSManaged public func addToAccountRecords(_ values: NSSet)

    @objc(removeAccountRecords:)
    @NSManaged public func removeFromAccountRecords(_ values: NSSet)

}

// MARK: Generated accessors for transactions
extension AccountDb {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionDb)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionDb)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension AccountDb : Identifiable {

}
