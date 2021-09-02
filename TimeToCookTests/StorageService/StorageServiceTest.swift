//
//  StorageService.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 02.09.2021.
//

import XCTest
import CoreData
@testable import TimeToCook

final class StorageServiceTest: XCTestCase {
    var sut: StorageServiceProtocol!
    var stack: CoreDataStackProtocol!

    override func setUp() {
        super.setUp()
        stack = CoreDataStackMock()
        sut = StorageService(coreDataStack: stack)
    }

    override func tearDown() {
        sut = nil
        stack = nil
        super.tearDown()
    }

    func testThatProductWillBeAddedToStorage() {
        // arrange
        let product = ProductStub()

        // act
        sut.update(product: [ProductDTO(width: product)])
        let receivedProduct = sut.fetchProducts().first
        sut.deleteAll()

        // assert
        XCTAssertEqual(receivedProduct?.code, product.code)
    }

    func testThatProductWillBeDeletedFromStorage() {
        // arrange
        let product = ProductStub()

        // act
        sut.update(product: [ProductDTO(width: product)])
        sut.delete(product: [ProductDTO(width: product)])
        let storageData = sut.fetchProducts()
        sut.deleteAll()

        // assert
        XCTAssertEqual(storageData.count, 0)
    }

    func testThatAllProductWillBeDeletedFromStorage() {
        // arrange
        let products = [ProductDTO(width: ProductStub(code: "12345")),
                        ProductDTO(width: ProductStub(code: "54321"))]

        // act
        sut.update(product: products)
        sut.deleteAll()
        let storageData = sut.fetchProducts()

        // assert
        XCTAssertEqual(storageData.count, 0)
    }
}
