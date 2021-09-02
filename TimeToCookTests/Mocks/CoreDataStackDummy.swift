//
//  CoreDataStackStub.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 01.09.2021.
//

import Foundation
import CoreData

final class CoreDataStackDummy: CoreDataStackProtocol {

    func getEntity() -> String { "" }
    var mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var backgroundContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
}
