//
//  TransactionDb+CoreDataProperties.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//
//

import Foundation
import CoreData


extension TransactionDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionDb> {
        return NSFetchRequest<TransactionDb>(entityName: "TransactionDb")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var categoryType: String?
    @NSManaged public var currencyCode: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var amount: Int64
    @NSManaged public var type: String?
    @NSManaged public var date: Date?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var note: String?
    @NSManaged public var transferAccountId: UUID?
    @NSManaged public var account: AccountDb?
    @NSManaged public var transactionRecords: NSSet?

}

// MARK: Generated accessors for transactionRecords
extension TransactionDb {

    @objc(addTransactionRecordsObject:)
    @NSManaged public func addToTransactionRecords(_ value: TransactionRecordDb)

    @objc(removeTransactionRecordsObject:)
    @NSManaged public func removeFromTransactionRecords(_ value: TransactionRecordDb)

    @objc(addTransactionRecords:)
    @NSManaged public func addToTransactionRecords(_ values: NSSet)

    @objc(removeTransactionRecords:)
    @NSManaged public func removeFromTransactionRecords(_ values: NSSet)

}

extension TransactionDb : Identifiable {

}
