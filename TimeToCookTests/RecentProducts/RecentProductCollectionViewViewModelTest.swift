//
//  xddee.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 30.08.2021.
//

import Foundation

import XCTest
@testable import TimeToCook

class RecentProductCollectionViewViewModelTest: XCTestCase {

    var sut: RecentProductCollectionViewViewModel?
    var storageService: StorageServiceProtocol?
    var coreDataStack: CoreDataStackProtocol?

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataStack = CoreDataStackStub() 
        storageService = StorageServiceDummy(coreDataStack: coreDataStack!)
        sut = RecentProductCollectionViewViewModel(storageService: storageService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        coreDataStack = nil
        storageService = nil
        try super.tearDownWithError()
    }

    func testThatNumberOfItemInSectionReturnZero() {
        // arrange
        let products = [Product]()

        // act
        sut?.products = products

        // assert
        XCTAssertEqual(sut?.numberOfItemsInSection, 0)
    }

    func testThatContentIsNotEmptyIfProductsCountGreaterThanZero() {
        // arrange
        let products = [ProductStub()]

        // act
        sut?.products = products

        // assert
        XCTAssertFalse(sut!.contentIsEmpty())
    }
}
