//
//  TimeToCookUITests.swift
//  TimeToCookUITests
//
//  Created by Никита Гвоздиков on 30.08.2021.
//

import XCTest

var app: XCUIApplication!

protocol Page {
    var app: XCUIApplication { get }
    init(app: XCUIApplication)
}

class TimeToCookUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("disableAnimations")
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testThatStartButtonIsDisabledWhilePickerViewValueIsZero() {
        // Arrange
        let tabBarPage = TabBarPage(app: app)
        // Act
        let timerPage = tabBarPage
            .tapRecentButton()
            .tapTimerButton()
        // Assert
        XCTAssertFalse(timerPage.startButton.isEnabled)
    }

    func testThatStartButtonIsEnabledWhilePickerViewValueIsNotZero() {
        // Arrange
        let tabBarPage = TabBarPage(app: app)
        // Act
        let timerPage = tabBarPage
            .tapRecentButton()
            .tapTimerButton()
            .changeMinutes()
            .tapStartButton()
            .tapStopButton()
        // Assert
        XCTAssertTrue(timerPage.startButton.isEnabled)
    }
}

class TabBarPage: Page {

    var app: XCUIApplication

    private var howToCookButton: XCUIElement { app.tabBars.buttons["Как варить"] }
    private var recentButton: XCUIElement { app.tabBars.buttons["Недавние"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func tapRecentButton() -> RecentProductPage {
        recentButton.tap()
        return RecentProductPage(app: app)
    }
}

class RecentProductPage: Page {

    var app: XCUIApplication

    private var timerButton: XCUIElement { app.navigationBars.buttons["timerNavButton"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func tapTimerButton() -> TimerPage {
        timerButton.tap()
        return TimerPage(app: app)
    }

}

class TimerPage: Page {

    var app: XCUIApplication

    private var stopButton: XCUIElement { app.buttons["stopTimer"] }
    var startButton: XCUIElement { app.buttons["startTimer"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func changeMinutes() -> Self {
        app.pickerWheels.element.adjust(toPickerWheelValue: "20")
        return self
    }

    func tapStartButton() -> Self {
        startButton.tap()
        return self
    }

    func tapStopButton() -> Self {
        stopButton.tap()
        return self
    }
}
