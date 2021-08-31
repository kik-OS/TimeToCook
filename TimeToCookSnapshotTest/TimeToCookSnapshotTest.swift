//
//  TimeToCookSnapshotTest.swift
//  TimeToCookSnapshotTest
//
//  Created by Никита Гвоздиков on 31.08.2021.
//

import XCTest
import SnapshotTesting
@testable import TimeToCook

class TimeToCookSnapshotTest: XCTestCase {

    var sut: TimerViewController?
    var viewModel: TimerViewModel?
    var timerServise: TimerServiceProtocol?
    var notificationService: NotificationServiceProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()

        timerServise = TimerService()
        notificationService = NotificationService()
        viewModel = TimerViewModel(timerService: timerServise!,
                                   notificationService: notificationService!)
        sut = TimerViewController(viewModel: viewModel!)
    }

    override func tearDownWithError() throws {
        sut = nil
        timerServise = nil
        notificationService = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testScreenSnapshot() {
        assertSnapshot(matching: sut!, as: .image(on: .iPhoneSe))
    }
}
