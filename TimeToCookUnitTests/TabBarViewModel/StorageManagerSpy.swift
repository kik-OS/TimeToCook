//
//  StorageManagerMock.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 22.08.2021.
//

import Foundation

final class StorageManagerDummy: StorageServiceProtocol {
    func createTemporaryProductForDemonstration() {

    }

    func fetchData() -> [ProductCD] {
        [ProductCD()]
    }
    func saveProductCD(product: ProductProtocol) {
    }

    func convertFromProductCDToProduct(productCD: ProductCD) -> ProductProtocol? {
        ProductFake()
    }

    func deleteProductCD(_ productCD: ProductCD) {
    }

    func saveContext() {
    }
}
