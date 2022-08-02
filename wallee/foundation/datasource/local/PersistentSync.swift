//
//  PersistenceReadDao.swift
//  wallee
//
//  Created by Wisnu Kurniawan on 02/08/22.
//

import CoreData
import Foundation

class PersistentSync {
    private static let TAG = "PersistentSync"

    private let container: NSPersistentContainer

    /// A peristent history token used for fetching transactions from the store.
    private var lastToken: NSPersistentHistoryToken?

    init(container: NSPersistentContainer) {
        self.container = container
    }

    func sync() async {
        do {
            try await syncHistory()
        } catch {
            Loggr.debug(tag: PersistentSync.TAG) {
                "\(error.localizedDescription)"
            }
        }
    }

    private func syncHistory() async throws {
        Loggr.debug(tag: PersistentSync.TAG) {
            "Start fetching persistent history changes from the store..."
        }

        let taskContext = self.container.newTaskContext()
        taskContext.name = "persistentHistoryContext"

        try await taskContext.perform {
            // Execute the persistent history change since the last transaction.
            /// - Tag: fetchHistory
            let changeRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: self.lastToken)
            let historyResult = try taskContext.execute(changeRequest) as? NSPersistentHistoryResult
            if let history = historyResult?.result as? [NSPersistentHistoryTransaction], !history.isEmpty {
                self.mergePersistent(from: history)
                return
            }

            Loggr.debug(tag: PersistentSync.TAG) {
                "No persistent history transactions found."
            }

            throw LocalError.persistentHistoryChangeError
        }

        Loggr.debug(tag: PersistentSync.TAG) {
            "Finished merging history changes."
        }
    }

    private func mergePersistent(from history: [NSPersistentHistoryTransaction]) {
        Loggr.debug(tag: PersistentSync.TAG) {
            "Received \(history.count) persistent history transactions."
        }

        // Update view context with objectIDs from history change request.
        /// - Tag: mergeChanges
        let viewContext = container.viewContext
        viewContext.perform {
            for transaction in history {
                viewContext.mergeChanges(fromContextDidSave: transaction.objectIDNotification())
                self.lastToken = transaction.token
            }
        }
    }
}
