//
//  TimeToCookTests.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 17.08.2021.
//

import XCTest
@testable import TimeToCook

var sut: ProductInfoViewModel?
var timerService: TimerServiceProtocol?
var notificationService: NotificationServiceProtocol?

class ProductInfoViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        timerService = TimerService()
        notificationService = NotificationServiceDummy()
        sut = ProductInfoViewModel(timerService: timerService!,
                                   notificationService: notificationService!)
    }

    override func tearDownWithError() throws {
        timerService = nil
        notificationService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testThatButtonStartCookTappedMustBeFalseAfterUpdateProduct() {
        // arrange
        let product: ProductProtocol? = nil

        // act
        sut?.buttonStartCookTapped = true
        sut?.updateProduct(product: product)

        // assert
        XCTAssertFalse(sut?.buttonStartCookTapped ?? true)
    }

    func testThatPropertyProductImageReturnCorrectImageName() {
        // arrange
        let product = ProductFake()

        // act
        sut?.updateProduct(product: product)

        // assert
        XCTAssertEqual(sut?.productImage, "Рис.png")
    }

    func testThatPropertyWeightReturnCorrectProductWeight() {
        // arrange
        let product = ProductFake()
        // act
        sut?.updateProduct(product: product)

        // assert
        XCTAssertEqual(sut?.weight, "200 г.")
    }

    func testThatPropertyWeightReturnNotFoundIfProductIsNil() {
        // arrange
        let product = ProductFake()
        sut?.updateProduct(product: product)

        // act
        sut?.updateProduct(product: nil)

        // assert
        XCTAssertEqual(sut?.weight, "Н/Д")
    }

    func testThatPropertyCookingTimeReturnCorrectTimeOfCooking() {
        // arrange
        let product = ProductFake()

        // act
        sut?.updateProduct(product: product)

        // assert
        XCTAssertEqual(sut?.cookingTime, "20 мин.")
    }

    func testThatProductInfoStackIsHiddenWhenProductIsNil() {
        // arrange
        let product: ProductProtocol? = nil

        // act
        sut?.updateProduct(product: product)

        // assert
        XCTAssertNil(sut?.product)
        XCTAssertTrue(sut?.isHiddenProductStackView ?? false)
    }

    func testThatInitializationOfProductIsWorking() {
        // arrange
        let product = ProductFake()

        // act
        sut = ProductInfoViewModel(product: product,
                                   timerService: timerService!,
                                   notificationService: notificationService!)

        // assert
        XCTAssertNotNil(sut?.product)
    }

    func testThatTimerViewModelReturnCorrectTimeAfterInitByProductInfoVM() {
        // arrange
        let product = ProductFake()

        // act
        sut?.updateProduct(product: product)
        let timerViewModel = sut?.getTimerViewModel()

        // assert
        XCTAssertEqual(timerViewModel?.minutes, 20)
    }

    func testThatCurrentStateIsChangeToFirstStateIfProductIsNil() {
        // arrange
        let product = ProductFake()
        sut?.updateProduct(product: product)
        var currentState: String?
        let firstCompletion  = { currentState = "firstState" }
        sut?.needUpdateViewForFirstStep = firstCompletion

        // act
        sut?.updateProduct(product: nil)
        sut?.checkCurrentStateAndUpdateView()

        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "firstState")
    }

    func testThatCurrentStateIsChangeToSecondState() {
        // arrange
        let product = ProductFake()
        var currentState: String?
        let secondCompletion = { currentState = "secondState" }
        sut?.needUpdateViewForSecondStep = secondCompletion

        // act
        sut?.updateProduct(product: product)
        sut?.checkCurrentStateAndUpdateView()

        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "secondState")
    }

    func testThatCurrentStateIsChangeToThirdState() {
        // arrange
        let product = ProductFake()
        sut?.updateProduct(product: product)
        var currentState: String?
        let thirdCompletion = { currentState = "thirdState" }
        sut?.needUpdateViewForThirdStep = thirdCompletion

        // act
        sut?.buttonStartCookTapped = true
        sut?.checkCurrentStateAndUpdateView()

        // assert
        XCTAssertNotNil(currentState)
        XCTAssertEqual(currentState, "thirdState")
    }

    func testThatFuncCellViewModelReturnCorrectInstructionCellViewModel() {
        // arrange
        let product = ProductFake()
        sut?.updateProduct(product: product)
        let indexPath = IndexPath(row: 2, section: 0)
        let instructionText = Inscriptions.instructionOfCookingThirdStep

        // act
        let cellViewModel = sut?.cellViewModel(at: indexPath)

        // assert
        XCTAssertEqual(cellViewModel?.instrImage, "instr2")
        XCTAssertEqual(cellViewModel?.numberOfCard, "3")
        XCTAssertEqual(cellViewModel?.getInstrLabel(), instructionText)
        XCTAssertNotNil(cellViewModel?.isShowNextLabel)
        XCTAssertFalse(cellViewModel?.isShowNextLabel ?? true)
    }

}
