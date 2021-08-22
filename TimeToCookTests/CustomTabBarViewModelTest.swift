//
//  CustomTabBarViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 21.08.2021.
//

import XCTest
@testable import TimeToCook



class CustomTabBarViewModelTest: XCTestCase {
    
    var sut: CustomTabBarViewModel?
    var firebaseServiceMock: FirebaseServiceProtocol?
    
    override func setUpWithError() throws {
        firebaseServiceMock = FirebaseServiceMock()
        sut = CustomTabBarViewModel(firebaseService: firebaseServiceMock!)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        firebaseServiceMock = nil
        try super.tearDownWithError()
    }
    
    
    
}
