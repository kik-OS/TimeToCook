//
//  CustomTabBarViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 21.08.2021.
//

import XCTest
@testable import TimeToCook

class TabBarViewModelTest: XCTestCase {

    var sut: TabBarViewModel?
    var firebaseServiceMock: FirebaseServiceProtocol?
    var storageManagerDummy: StorageServiceProtocol?
    var deviceService: DeviceServiceProtocol?
    var timerService: TimerServiceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        firebaseServiceMock = FirebaseServiceMock()
        storageManagerDummy = StorageManagerDummy()
        deviceService = DeviceService()
        timerService = TimerService()
        sut = TabBarViewModel(firebaseService: firebaseServiceMock!,
                                    storageManager: storageManagerDummy!,
                                    deviceService: deviceService!,
                                    timerService: timerService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        firebaseServiceMock = nil
        storageManagerDummy = nil
        try super.tearDownWithError()
    }

    func testThatFunctionForFindProductIsWorkingWithFoundedProduct() {
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

    func testThatFunctionFoundProductCanProcessFailureResult() {
        // arrange
        let productCode = UUID().uuidString
        var scannedCode: String?

        sut?.addingNewProductOffer = { code in
            scannedCode = code
        }

        // act
        sut?.findProduct(byCode: productCode)

        // assert
        XCTAssertNotNil(scannedCode)
        XCTAssertEqual(scannedCode, productCode)
    }

    func testThatFuncGetAddingNewProductViewModelReturnCorrectResult() {
        // arrange
        let productCode = UUID().uuidString

        // act
        let addingNewProductVM = sut?.getAddingNewProductViewModel(withCode: productCode)

        // assert
        XCTAssertNotNil(addingNewProductVM?.codeLabelText)
        XCTAssertEqual(addingNewProductVM?.codeLabelText, productCode)
    }
}
