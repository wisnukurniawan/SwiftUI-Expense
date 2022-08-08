//
//  Currency.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

struct Currency: Equatable, Hashable {
    var currencyCode: String
    var countryCode: String
}

extension Currency {
    static let defaultValue = Currency(currencyCode: "USD", countryCode: "US")
}
