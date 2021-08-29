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
    var notificationService: NotificationServiceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        timerService = TimerService()
        notificationService = NotificationServiceDummy()
        sut = TimerViewModel(timerService: timerService!,
                             notificationService: notificationService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        timerService = nil
        notificationService = nil
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

    func testThatMethodStartTimerIsWorking() {
        // arrange
        let cookingTimeInMinutes = 20
        let cookingTimeInSeconds = cookingTimeInMinutes * 60

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()

        // assert
        XCTAssertEqual(cookingTimeInSeconds, timerService?.getTimerTime().totalSeconds)
    }

    func testThatPickerStackViewIsHiddenWhenTheTimerIsWorking() {
        // arrange
        let cookingTimeInMinutes = 20

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()

        // assert
        XCTAssertTrue(sut!.isHiddenPickerStackView)
    }

    func testThatDiagramStackViewIsShowingWhenTheTimerStart() {
        // arrange
        let cookingTimeInMinutes = 20

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()

        // assert
        XCTAssertFalse(sut!.isHiddenDiagramStackView)
    }

    func testThatStartButtonIsEnabled() {
        // arrange
        let cookingTimeInMinutes = 20

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()
        sut?.stopTimer()

        // assert
        XCTAssertFalse(timerService!.isActive)
        XCTAssertTrue(sut!.isEnabledStartButton)
    }

    func testThatStartButtonIsNotHidden() {
        // arrange
        let cookingTimeInMinutes = 20

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()

        // assert
        XCTAssertTrue(timerService!.isActive)
        XCTAssertTrue(sut!.isHiddenStartButton)
    }

    func testThatStopButtonIsNotHidden() {
        // arrange
        let cookingTimeInMinutes = 20

        // act
        sut?.updateTimeTo(minutes: cookingTimeInMinutes)
        sut?.startTimer()

        // assert
        XCTAssertTrue(timerService!.isActive)
        XCTAssertFalse(sut!.isHiddenStopButton)
    }
}
