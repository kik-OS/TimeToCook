//
//  CustomTabBarViewModelTest.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 21.08.2021.
//

import XCTest
@testable import TimeToCook

//class FirebaseServiceMock: FirebaseServiceProtocol {
//    func saveProduct(_ product: Product) {
//        <#code#>
//    }
//
//    func saveProducts(_ products: [Product]) {
//        <#code#>
//    }
//
//    func fetchProduct(byCode code: String, completion: @escaping (Result<Product, FirebaseServiceError>) -> Void) {
//        <#code#>
//    }
//
//    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
//        <#code#>
//    }
//
//    func removeProduct(byCode code: String) {
//        <#code#>
//    }
//
//    func saveCategories(_ categories: [Category]) {
//        <#code#>
//    }
//
//    func fetchCategories(completion: @escaping ([Category]) -> Void) {
//        <#code#>
//    }
//
//
//}

class CustomTabBarViewModelTest: XCTestCase {
    
    var sut: CustomTabBarViewModel?
    
    override func setUpWithError() throws {
//        sut = CustomTabBarViewModel(firebaseService: <#T##FirebaseServiceProtocol#>)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
}
