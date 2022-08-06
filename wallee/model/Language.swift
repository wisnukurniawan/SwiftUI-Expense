//
//  Language.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 06/08/22.
//

import Foundation

enum Language {
    case english
    case indonesia
}

extension Language {
    var code: String {
        switch self {
        case .english:
            return LanguageCode.english
        case .indonesia:
            return LanguageCode.indonesia
        }
    }
}
