//
//  TransactionRecordDb+CoreDataProperties.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//
//

import Foundation
import CoreData


extension TransactionRecordDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionRecordDb> {
        return NSFetchRequest<TransactionRecordDb>(entityName: "TransactionRecordDb")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Int64
    @NSManaged public var createdAt: Date?
    @NSManaged public var transaction: TransactionDb?

}

extension TransactionRecordDb : Identifiable {

}
