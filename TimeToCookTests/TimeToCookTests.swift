//
//  TimeToCookTests.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 17.08.2021.
//

import XCTest
@testable import TimeToCook

var sut: ProductInfoViewModel?

class ProductFake: ProductProtocol {
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
        let product = ProductFake()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.productImage, "Рис.png")
    }
    
    func testThatPropertyWeightReturnCorrectProductWeight() {
        // arrange
        let product = ProductFake()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertEqual(productInfoViewModel.weight, "200 г.")
    }
    
    func testThatPropertyWeightReturnNotFoundIfProductIsNil() {
        // arrange
        let product = ProductFake()
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // act
        productInfoViewModel.updateProduct(product: nil)
        
        // assert
        XCTAssertEqual(productInfoViewModel.weight, "Н/Д")
    }
    
    func testThatPropertyCookingTimeReturnCorrectTimeOfCooking() {
        // arrange
        let product = ProductFake()
        
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
        let product = ProductFake()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        
        // assert
        XCTAssertNotNil(productInfoViewModel.product)
    }
    
    func testThatTimerViewModelReturnCorrectTimeAfterInitByProductInfoVM() {
        // arrange
        let product = ProductFake()
        
        // act
        let productInfoViewModel = ProductInfoViewModel(product: product)
        let timerViewModel = productInfoViewModel.getTimerViewModel()
        
        // assert
        XCTAssertEqual(timerViewModel.minutes, 20)
    }
    
    func testThatCurrentStateIsChangeToFirstStateIfProductIsNil() {
        // arrange
        let product = ProductFake()
        let productInfoViewModel = ProductInfoViewModel(product: product)
        var currentState: String?
        let firstCompletion  = { currentState = "firstState" }
        productInfoViewModel.needUpdateViewForFirstStep = firstCompletion
        
        // act
        productInfoViewModel.updateProduct(product: nil)
        productInfoViewModel.checkCurrentStateAndUpdateView()
        
        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "firstState")
    }
    
    func testThatCurrentStateIsChangeToSecondState() {
        // arrange
        let product = ProductFake()
        let productInfoViewModel = ProductInfoViewModel()
        var currentState: String?
        let secondCompletion = { currentState = "secondState" }
        productInfoViewModel.needUpdateViewForSecondStep = secondCompletion
        
        // act
        productInfoViewModel.updateProduct(product: product)
        productInfoViewModel.checkCurrentStateAndUpdateView()
        
        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "secondState")
    }
    
    func testThatCurrentStateIsChangeToThirdState() {
        // arrange
        let product = ProductFake()
        let productInfoViewModel = ProductInfoViewModel(product: product)
        var currentState: String?
        let thirdCompletion = { currentState = "thirdState" }
        productInfoViewModel.needUpdateViewForThirdStep = thirdCompletion
        
        // act
        productInfoViewModel.buttonStartCookTapped = true
        productInfoViewModel.checkCurrentStateAndUpdateView()
        
        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "thirdState")
    }
    
    func testThatFuncCellViewModelReturnCorrectInstructionCellViewModel() {
        // arrange
        let product = ProductFake()
        let productInfoViewModel = ProductInfoViewModel(product: product)
        let indexPath = IndexPath(row: 2, section: 0)
        let instructionText = Inscriptions.instructionOfCookingThirdStep
        
        // act
        let cellViewModel = productInfoViewModel.cellViewModel(at: indexPath)
        
        // assert
        XCTAssertEqual(cellViewModel?.instrImage, "instr2")
        XCTAssertEqual(cellViewModel?.numberOfCard, "3")
        XCTAssertEqual(cellViewModel?.getInstrLabel(), instructionText)
        XCTAssertNotNil(cellViewModel?.isShowNextLabel)
        XCTAssertEqual(cellViewModel?.isShowNextLabel, false)
    }
    
}
