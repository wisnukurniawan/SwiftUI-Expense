//
//  FirebaseInitializer.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 03/08/22.
//

import Firebase
import Foundation
import UIKit

class FireBaseInitializer: Initializer {
    func create(application: UIApplication) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
