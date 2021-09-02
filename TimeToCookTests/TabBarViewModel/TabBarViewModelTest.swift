//
//  CustomTabBarViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 21.08.2021.
//

import XCTest
@testable import TimeToCook

class TabBarViewModelTest: XCTestCase {

    var sut: TabBarViewModelProtocol?
    var firebaseServiceMock: FirebaseServiceProtocol?
    var storageManagerDummy: StorageServiceProtocol?
    var deviceService: DeviceServiceProtocol?
    var timerService: TimerServiceProtocol?
    var notificationService: NotificationServiceProtocol?
    var coreDataStack: CoreDataStackProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        firebaseServiceMock = FirebaseServiceMock()
        coreDataStack = CoreDataStackDummy()
        deviceService = DeviceServiceDummy()
        timerService = TimerService()
        notificationService = NotificationServiceDummy()
        storageManagerDummy = StorageServiceDummy(coreDataStack: coreDataStack!)
        sut = TabBarViewModel(notificationService: notificationService!,
                              firebaseService: firebaseServiceMock!,
                              storageManager: storageManagerDummy!,
                              deviceService: deviceService!,
                              timerService: timerService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        firebaseServiceMock = nil
        storageManagerDummy = nil
        deviceService = nil
        timerService = nil
        coreDataStack = nil
        try super.tearDownWithError()
    }

    func testThatFunctionForFindProductIsWorkingWithFoundedProduct() {
        // arrange
        let productCode = UUID().uuidString
        let product = ProductStub(code: productCode)
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

    func testThatGetProductInfoViewModelReturnCorrectResult() {
        // arrange
        let product = ProductStub()

        // act
        let productInfoVM = sut?.getProductInfoViewModel(product: product)

        // assert
        XCTAssertEqual(product.code, productInfoVM?.product?.code)
        XCTAssertNotNil(productInfoVM?.product)

    }

    func testThatConstantForMiddleButtonIsComputedCorrectly() {
        // arrange
        let currentDevice: DeviceModel = .iPhone8
        let constant: Float = 10

        // act
        deviceService?.currentType = currentDevice

        // assert
        XCTAssertEqual(sut?.constantForMiddleButton, constant)
    }

    func testThatSizeForMiddleButtonIsComputedCorrectly() {
        // arrange
        let currentDevice: DeviceModel = .iPhone11
        let constant: Float = 72

        // act
        deviceService?.currentType = currentDevice

        // assert
        XCTAssertEqual(sut?.sizeForMiddleButton, constant)
    }
}
