//
//  TimerViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 29.08.2021.
//

import Foundation

import XCTest
@testable import TimeToCook

class TimerViewModelTest: XCTestCase {

    var sut: TimerViewModelProtocol?
    var timerService: TimerServiceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        timerService = TimerService()
        sut = TimerViewModel(timerService: timerService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        timerService = nil
        try super.tearDownWithError()
    }

    func testThatUpdateTimeToWorkingCorrectly() {

        // arrange
        let cookingTime = 20

        // act
        sut?.updateTimeTo(minutes: cookingTime)

        // assert
        XCTAssertEqual(cookingTime, sut?.minutes)
    }

    func testThat() {

        // arrange
        let cookingTime = 20

        // act
        sut?.updateTimeTo(minutes: cookingTime)

        // assert
        XCTAssertEqual(cookingTime, sut?.minutes)
    }
}
