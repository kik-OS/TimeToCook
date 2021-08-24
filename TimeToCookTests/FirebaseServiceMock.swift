//
//  FirebaseServiceMock.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 22.08.2021.
//

import Foundation

class FirebaseServiceMock {

    var storage: [ProductProtocol] = Array(repeating: ProductFake(), count: 5)
}

extension FirebaseServiceMock: FirebaseServiceProtocol {

    func saveProduct(_ product: ProductProtocol) {
        storage.append(product)
    }

    func saveProducts(_ products: [ProductProtocol]) {
        storage += products
    }

    func fetchProduct(byCode code: String,
                      completion: @escaping (Result<ProductProtocol, FirebaseServiceError>) -> Void) {
        guard let product = storage.first(where: { $0.code == code }) else {
            completion(.failure(.modelInitializingError))
            return
        }
        completion(.success(product))
    }

    func fetchProducts(completion: @escaping (Result<[ProductProtocol], FirebaseServiceError>) -> Void) {

        guard !storage.isEmpty else {
            completion(.failure(.productsNotFound))
            return }
        let products = storage
        completion(.success(products))
    }

    func removeProduct(byCode code: String) {
        storage.removeAll(where: { $0.code == code })
    }

    func saveCategories(_ categories: [Category]) {}
    func fetchCategories(completion: @escaping ([Category]) -> Void) {}
}
