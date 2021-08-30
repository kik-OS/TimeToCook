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
        app.launch()
    }

func testThatSearchTextEntered() {
        // Arrange
        let tabBarPage = TabBarPage(app: app)

        // Act
        let timerPage = tabBarPage
            .tapRecentButton()
            .tapTimerButton()
            .changeMinutes()
            .tapStartButton()
        // Assert
    XCTAssertTrue(timerPage.timeDiagram.exists)

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

    private var startButton: XCUIElement { app.buttons["startTimer"] }
    private var stopButton: XCUIElement { app.buttons["stopTimer"] }
//    private var pickerView: XCUIElement { app.pickerWheels["timePicker"] }
    var timeDiagram: XCUIElement { app.otherElements["timeDiagram"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func changeMinutes() -> Self {
        app.pickerWheels.element.adjust(toPickerWheelValue: "1")
        return self
    }

    func tapStartButton() -> Self {
        startButton.tap()
        return self
    }
}
