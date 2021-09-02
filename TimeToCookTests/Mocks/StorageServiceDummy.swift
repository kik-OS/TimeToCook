//
//  StorageManagerMock.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 22.08.2021.
//

import Foundation

final class StorageServiceDummy: StorageServiceProtocol {
    init(coreDataStack: CoreDataStackProtocol) {

    }

    func update(product: [ProductDTO]) {

    }

    func delete(product: [ProductDTO]?) {

    }

    func deleteAll() {

    }

    func fetchProducts() -> [ProductDTO] {
        [ProductDTO]()
    }
}
