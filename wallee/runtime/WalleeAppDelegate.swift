//
//  AppDelegate.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import UIKit

class WalleeAppDelegate: NSObject, UIApplicationDelegate {
    
    private lazy var initializers: [Initializer] = [
        LoggrInitializer(),
        PersistentSyncInitializer()
    ]
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        initializers.forEach { item in
            _ = item.create(application: application)
        }
        return true
    }
    
    
    

    
}
