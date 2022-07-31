//
//  AccountRecordDb+CoreDataProperties.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//
//

import Foundation
import CoreData


extension AccountRecordDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountRecordDb> {
        return NSFetchRequest<AccountRecordDb>(entityName: "AccountRecordDb")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var amount: Int64
    @NSManaged public var createdAt: Date?
    @NSManaged public var account: AccountDb?

}

extension AccountRecordDb : Identifiable {

}
