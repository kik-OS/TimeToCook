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

    var sut: ProductInfoViewController?

    override func setUp() {
        sut = ProductInfoViewController(viewModel: ProductInfoViewModel(timerService: TimerService(), notificationService: NotificationService()))
      }
    func test_screenSnapshot() {
        assertSnapshot(matching: sut!, as: .image(on: .iPhoneSe))
      }
}
