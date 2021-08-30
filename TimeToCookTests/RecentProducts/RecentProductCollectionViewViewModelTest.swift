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

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageService = StorageServiceDummy()
        sut = RecentProductCollectionViewViewModel(storageService: storageService!)
    }

    override func tearDownWithError() throws {
        sut = nil
        storageService = nil
        try super.tearDownWithError()
    }

    func testThatNumberOfItemInSectionReturnZero() {
        // arrange
        let products = [ProductCD]()

        // act
        sut?.productsCD = products

        // assert
        XCTAssertEqual(sut?.numberOfItemsInSection, 0)
    }

    func testThatContentIsNotEmptyIfProductCountGreaterThanZero() {
        // arrange
        let products = storageService?.fetchData()

        // act
        sut?.productsCD = products!

        // assert
        XCTAssertFalse(sut!.contentIsEmpty())
    }
}
