//
//  CustomTabBarViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 21.08.2021.
//

import XCTest
@testable import TimeToCook

class CustomTabBarViewModelTest: XCTestCase {

    var sut: CustomTabBarViewModel?
    var firebaseServiceMock: FirebaseServiceProtocol?
    var storageManagerDummy: StorageManagerProtocol?

    override func setUpWithError() throws {
        firebaseServiceMock = FirebaseServiceMock()
        storageManagerDummy = StorageManagerDummy()
        sut = CustomTabBarViewModel(firebaseService: firebaseServiceMock!,
                                    storageManager: storageManagerDummy!)
    }

    override func tearDownWithError() throws {
        sut = nil
        firebaseServiceMock = nil
        storageManagerDummy = nil
        try super.tearDownWithError()
    }

    func testThatFuncForFindProductIsWorkingCorrectly() {
        // arrange
        let productCode = UUID().uuidString
        let product = ProductFake(code: productCode)
        var foundedProduct: ProductProtocol?

        sut?.productDidReceive = { product in
           foundedProduct = product
        }

        // act
        firebaseServiceMock?.saveProduct(product)
        sut?.findProduct(byCode: productCode)

        // assert
        XCTAssertNotNil(foundedProduct)
        XCTAssertEqual(foundedProduct?.code, productCode)
    }
}
