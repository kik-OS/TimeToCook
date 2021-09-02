//
//  AddingNewProductViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 29.08.2021.
//

import Foundation

import XCTest
@testable import TimeToCook

class AddingNewProductViewModelTest: XCTestCase {

    var sut: AddingNewProductViewModelProtocol?
    var firebaseService: FirebaseServiceFake?
    var notificationService: NotificationServiceProtocol?
    var testCode: String? = "123456789"

    override func setUpWithError() throws {
        try super.setUpWithError()
        firebaseService = FirebaseServiceFake()
        notificationService = NotificationServiceDummy()
        sut = AddingNewProductViewModel(code: testCode!,
                                        firebaseService: firebaseService!,
                                        notificationService: notificationService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        testCode = nil
        firebaseService = nil
        notificationService = nil
        try super.tearDownWithError()
    }

    func testThatValidationIsWorkingIfOneOfTextFieldIsNil() {
        // arrange
        let product = ProductStub()

        // act
        sut?.textFromProducerTF = product.producer
        sut?.textFromCategoryTF = product.category
        let validation = sut!.validation()

        // assert
        XCTAssertNotNil(sut?.textFromProducerTF)
        XCTAssertNotNil(sut?.textFromCategoryTF)
        XCTAssertFalse(validation)
    }

    func testThatValidationIsTrueIfAllConditionAreWell() {
        // arrange
        let product = ProductStub()

        // act
        sut?.textFromProducerTF = product.producer
        sut?.textFromCategoryTF = product.category
        sut?.textFromWeightTF = String(product.weight!)
        sut?.textFromCookingTimeTF = String(product.cookingTime)
        sut?.textFromWaterRatioTF = String(product.waterRatio)
        sut?.textFromTitleProductTF = product.title
        let validation = sut!.validation()

        // assert
        XCTAssertNotNil(sut?.textFromProducerTF)
        XCTAssertNotNil(sut?.textFromCategoryTF)
        XCTAssertNotNil(sut?.textFromWeightTF)
        XCTAssertNotEqual(sut?.textFromTitleProductTF, "")
        XCTAssertNotEqual(sut?.textFromCategoryTF, "")
        XCTAssertTrue(validation)
        XCTAssertNotNil(sut?.completedProduct)
    }

    func testThatGetCategoriesWillBeReceiveCategoriesCorrectly() {
        // arrange
        let categories = [Category(name: "Вареники")]

        // act
        sut?.getCategories()

        // assert
        XCTAssertNotNil(sut?.categories)
        XCTAssertEqual(sut?.categories.first?.name, categories.first?.name)
    }

    func testThatCreateProductInFBIsWorkCorrectly() {
        // arrange
        let product = ProductStub()
        var resultFromFB: Result<ProductProtocol, FirebaseServiceError>?
        let didReceiveResponse = expectation(description: #function)

        // act
        sut?.textFromProducerTF = product.producer
        sut?.textFromCategoryTF = product.category
        sut?.textFromWeightTF = String(product.weight!)
        sut?.textFromCookingTimeTF = String(product.cookingTime)
        sut?.textFromWaterRatioTF = String(product.waterRatio)
        sut?.textFromTitleProductTF = product.title
        sut?.createProductInFB()

        firebaseService?.fetchProduct(byCode: product.code, completion: { result in
            resultFromFB = result
            didReceiveResponse.fulfill()
        })

        wait(for: [didReceiveResponse], timeout: 2)

        // assert
        XCTAssertNotNil(resultFromFB?.get)
    }

    func testThatCalculationOfUpperResponderIsWorkingCorrectly() {
        // arrange
        let currentResponder = 2

        // act
        sut?.indexOfFirstResponder = currentResponder
        let upperResponder = sut?.calculationOfUpperResponder()

        // assert
        XCTAssertNotEqual(sut?.indexOfFirstResponder, 0)
        XCTAssertEqual(upperResponder, 1)
    }

    func testThatCalculationOfLowerResponderIsWorkingCorrectly() {
        // arrange
        let currentResponder = 2

        // act
        sut?.indexOfFirstResponder = currentResponder
        let lowerResponder = sut?.calculationOfLowerResponder()

        // assert
        XCTAssertNotEqual(sut?.indexOfFirstResponder, 0)
        XCTAssertEqual(lowerResponder, 3)
    }

    func testThatCalculationWaterRatioIsWorkingCorrectly() {
        // arrange
        let row = 2

        // act
        sut?.calculateWaterRatio(row: row)
        let waterRatio = sut?.waterRatio

        // assert
        XCTAssertEqual(waterRatio, 3.0)
    }

    func testThatPickerViewDidSelectAtIsWorkingForZeroIndex() {
        // arrange
        let row = 0
        let categories: [Category]?
        // act
        sut?.getCategories()
        categories = sut?.categories
        sut?.pickerViewDidSelectAt(row: row)

        // assert
        XCTAssertEqual(categories?.first?.name, sut?.textFromCategoryTF)
    }

    func testThatPickerViewDidSelectAtIsWorkingForLastIndex() {
        // arrange
        let row = 4
        let listOfWaterRatio = sut?.listOfWaterRatio
        // act
        sut?.indexOfFirstResponder = 5
        sut?.pickerViewDidSelectAt(row: row)

        // assert
        XCTAssertEqual(listOfWaterRatio![row], sut?.textFromWaterRatioTF)
    }
}
