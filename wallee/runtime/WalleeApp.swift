//
//  WalleeApp.swift
//  Wallee
//
//  Created by Wisnu Kurniawan on 31/07/22.
//

import SwiftUI

@main
struct WalleeApp: App {
    
    @UIApplicationDelegateAdaptor(WalleeAppDelegate.self) private var appDelegate
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, LocalModule.shared.container.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch (phase) {
            case .background:
                Loggr.debug {
                    "wisunkrn - background"
                }
            case .inactive:
                Loggr.debug {
                    "wisunkrn - inactive"
                }
            case .active:
                Loggr.debug {
                    "wisunkrn - active"
                }
            @unknown default:
                Loggr.debug {
                    "wisunkrn - default"
                }
            }
        }
    }
}
