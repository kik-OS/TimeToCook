//
//  AddingNewProductViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 29.08.2021.
//

import Foundation

import XCTest
@testable import TimeToCook

class AddingNewProductViewModelTest: XCTestCase {

    var sut: AddingNewProductViewModelProtocol?
    var firebaseService: FirebaseServiceMock?
    var notificationService: NotificationServiceProtocol?
    var testCode: String? = "123456789"

    override func setUpWithError() throws {
        try super.setUpWithError()
        firebaseService = FirebaseServiceMock()
        notificationService = NotificationServiceDummy()
        sut = AddingNewProductViewModel(code: testCode!,
                                        firebaseService: firebaseService!,
                                        notificationService: notificationService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        testCode = nil
        firebaseService = nil
        notificationService = nil
        try super.tearDownWithError()
    }

    

}
