//
//  Date+Ext.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 08/08/22.
//

import Foundation

var datePickerRange: ClosedRange<Date> {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "yyyy-MM-dd"
    let min = Date(timeInterval: 0, since: dateStringFormatter.date(from: "2000-01-01")!)
    let max = Date.now
    return min...max
}

func getStringFromDate(withFormat strFormat: String, date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = strFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.system
    return dateFormatter.string(from: date)
}
