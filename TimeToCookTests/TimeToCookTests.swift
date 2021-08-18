//
//  TimeToCookTests.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 17.08.2021.
//

import XCTest
@testable import TimeToCook

var sut: ProductInfoViewModel?

class ProductInfoViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductInfoViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testThatInitializationOfProductIsWorking() {
        // arrange
        let product = Product(code: "", title: "", producer: "",
                              category: "", weight: 0, cookingTime: 0,
                              intoBoilingWater: true,
                              needStirring: true, waterRatio: 0)
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertNotNil(productInfoViewModel.product)
        XCTAssertTrue(productInfoViewModel.product == product)
    }
    
    func testThatButtonStartCookTappedMustBeFalseAfterUpdateProduct() {
        // arrange
        let productInfoViewModel = ProductInfoViewModel()
        let product: Product? = nil
        
        // act
        productInfoViewModel.buttonStartCookTapped = true
        productInfoViewModel.updateProduct(product: product)
        
        // assert
        XCTAssertFalse(productInfoViewModel.buttonStartCookTapped)
    }
}
