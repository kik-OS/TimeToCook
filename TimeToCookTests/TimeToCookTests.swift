//
//  TimeToCookTests.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 17.08.2021.
//

import XCTest
@testable import TimeToCook

var sut: ProductInfoViewModel?

class FakeProduct: ProductProtocol {
    var weight: Int? = 200
    var code = "12345678"
    var title = "Title"
    var producer = "Producer"
    var category = "Рис"
    var cookingTime = 20
    var intoBoilingWater: Bool?
    var needStirring: Bool?
    var waterRatio = 3.0
}

class ProductInfoViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProductInfoViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testThatButtonStartCookTappedMustBeFalseAfterUpdateProduct() {
        // arrange
        let productInfoViewModel = ProductInfoViewModel()
        let product: ProductProtocol? = nil
        
        // act
        productInfoViewModel.buttonStartCookTapped = true
        productInfoViewModel.updateProduct(product: product)
        
        // assert
        XCTAssertFalse(productInfoViewModel.buttonStartCookTapped)
    }
    
    func testThatPropertyProductImageReturnCorrectImageName() {
        // arrange
        let product = FakeProduct()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.productImage, "Рис.png")
    }
    
    func testThatPropertyWeightReturnCorrectProductWeight() {
        // arrange
        let product = FakeProduct()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.weight, "200 г.")
    }
    
    func testThatPropertyCookingTimeReturnCorrectTimeOfCooking() {
        // arrange
        let product = FakeProduct()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.cookingTime, "20 мин.")
    }
    
    func testThatProductInfoStackIsHiddenWhenProductIsNil() {
        // arrange
        let product: ProductProtocol? = nil
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertNil(productInfoViewModel.product)
        XCTAssertTrue(productInfoViewModel.isHiddenProductStackView)
    }
    
    func testThatInitializationOfProductIsWorking() {
        // arrange
        let product = FakeProduct()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertNotNil(productInfoViewModel.product)
    }
    
    func testThatProductInfoViewModelReturnCorrectTimerViewModel() {
        // arrange
        let product = FakeProduct()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        let timerViewModel = productInfoViewModel.getTimerViewModel()
        
        // assert
        XCTAssertEqual(timerViewModel.minutes, 30)
    }
}
