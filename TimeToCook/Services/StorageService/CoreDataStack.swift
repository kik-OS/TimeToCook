//
//  CoreDataStack.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 01.09.2021.
//

import Foundation
import CoreData

// MARK: Protocol

protocol CoreDataStackProtocol {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
    func getEntity() -> String
    func saveContext()
}

extension CoreDataStackProtocol {
    func saveContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

class CoreDataStack: CoreDataStackProtocol {

    // MARK: Singletone

    static let shared = CoreDataStack()

    // MARK: Private Properties

    private var coordinator: NSPersistentStoreCoordinator
    private let moduleName = "TimeToCook"
    private let entityName = "MOProduct"

    // MARK: Properties

    /// Используется для чтения
    let mainContext: NSManagedObjectContext
    /// Используется для записи
    let backgroundContext: NSManagedObjectContext

    // MARK: Computed Properties

    private var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "TimeToCook", withExtension: "momd") else {
            fatalError("CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("CoreData MOMD is nil")
        }
        return model
    }()

    // MARK: Init

    private init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("\(moduleName).sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let storeType = NSSQLiteStoreType
        let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                       NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: storeType,
                                               configurationName: nil,
                                               at: url,
                                               options: options)
        } catch {
            fatalError("cant add persistent store: \(error)")
        }

        self.coordinator = coordinator
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = coordinator
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = coordinator
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.backgroundContext)
    }

    func getEntity() -> String { entityName }
}

// MARK: Extension

private extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            mainContext.performAndWait {
                mainContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}
