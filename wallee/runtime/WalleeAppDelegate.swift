//
//  AppDelegate.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import UIKit

class WalleeAppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        initLoggr()
        return true
    }

    private func initLoggr() {
        #if DEBUG
        let loggings: [Logging] = [DebugLogging()]
        #else
        let loggings: [Logging] = []
        #endif

        Loggr.initialize(loggings: loggings)
    }
}
