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
    
    func testThatPropertyProductImageReturnCorrectImageName() {
        // arrange
        let product = Product(code: "", title: "", producer: "",
                              category: "Рис", weight: 0,
                              cookingTime: 0, intoBoilingWater: nil,
                              needStirring: nil, waterRatio: 0)
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.productImage, "Рис.png")
    }
    
    func testThatPropertyWeightReturnCorrectProductWeight() {
        // arrange
        let product = Product(code: "", title: "", producer: "",
                              category: "", weight: 200,
                              cookingTime: 0, intoBoilingWater: nil,
                              needStirring: nil, waterRatio: 0)
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.weight, "200 г.")
    }
    
    func testThatPropertyCookingTimeReturnCorrectTimeOfCooking() {
        // arrange
        let product = Product(code: "", title: "", producer: "",
                              category: "", weight: 0,
                              cookingTime: 20, intoBoilingWater: nil,
                              needStirring: nil, waterRatio: 0)
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.cookingTime, "20 мин.")
    }
    
}
