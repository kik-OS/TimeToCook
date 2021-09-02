//
//  CoreDataStackMock.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 02.09.2021.
//

import Foundation
import CoreData
@testable import TimeToCook

final class CoreDataStackMock: CoreDataStackProtocol {

    var mainContext: NSManagedObjectContext
    var backgroundContext: NSManagedObjectContext

    private var coordinator: NSPersistentStoreCoordinator

    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        coordinator.addPersistentStore(with: description, completionHandler: { _, error in
            guard error == nil else {
                fatalError("fatal error")
            }
        })

        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = coordinator
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = mainContext

    }
    func getEntity() -> String { "MOProduct" }
}
