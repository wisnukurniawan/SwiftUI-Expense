//
//  PersistentSyncInitializer.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 03/08/22.
//

import Foundation
import UIKit

class PersistentSyncInitializer: Initializer {
    
    private var notificationToken: NSObjectProtocol?
    private lazy var persistent = PersistentSync(container: LocalModule.shared.container)

    func create(application: UIApplication) -> Bool {
        // Observe Core Data remote change notifications on the queue where the changes were made.
        notificationToken = NotificationCenter.default.addObserver(forName: .NSPersistentStoreRemoteChange, object: nil, queue: nil) { [self] _ in
            Loggr.debug {
                "Received a persistent store remote change notification."
            }

            Task {
                await persistent.sync()
            }
        }
        
        return true
    }

    deinit {
        if let observer = notificationToken {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
