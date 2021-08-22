//
//  FirebaseService.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 06.07.2021.
//

import FirebaseDatabase

// MARK: - Protocols

protocol FirebaseServiceProtocol {
    func saveProduct(_ product: ProductProtocol)
    func saveProducts(_ products: [ProductProtocol])
    func fetchProduct(byCode code: String,
                      completion: @escaping (Result<ProductProtocol, FirebaseServiceError>) -> Void)
    func fetchProducts(completion: @escaping (Result<[ProductProtocol], FirebaseServiceError>) -> Void)
    func removeProduct(byCode code: String)
    func saveCategories(_ categories: [Category])
    func fetchCategories(completion: @escaping ([Category]) -> Void)
}

final class FirebaseService: FirebaseServiceProtocol {
    
    // MARK: - Static properties
    
    static let shared = FirebaseService()
    
    // MARK: - Properties
    
    private let productsRef =  Database.database().reference().child("products")
    private let categoriesRef = Database.database().reference().child("categories")
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public methods
    
    func saveProduct(_ product: ProductProtocol) {
        productsRef.child(product.code).setValue(product.convertToDictionary())
    }
    
    func saveProducts(_ products: [ProductProtocol]) {
        products.forEach {
            productsRef.child($0.code).setValue($0.convertToDictionary())
        }
    }
    
    func fetchProduct(byCode code: String,
                      completion: @escaping (Result<ProductProtocol,
                                                    FirebaseServiceError>) -> Void) {
        productsRef.child(code).observe(.value) { snapshot in
            guard snapshot.exists() else {
                completion(.failure(.productNotFound))
                return
            }
            guard let product = Product(snapshot: snapshot) else {
                completion(.failure(.modelInitializingError))
                return
            }
            completion(.success(product))
        }
    }
    
    func fetchProducts(completion: @escaping (Result<[ProductProtocol],
                                                     FirebaseServiceError>) -> Void) {
        productsRef.observe(.value) { snapshot in
            guard snapshot.exists() else {
                completion(.failure(.productsNotFound))
                return
            }
            let products = snapshot.children.compactMap { Product(snapshot: $0 as? DataSnapshot ?? DataSnapshot()) }
            completion(.success(products))
        }
    }
    
    func removeProduct(byCode code: String) {
        productsRef.child(code).removeValue()
    }
    
    func saveCategories(_ categories: [Category]) {
        categories.forEach {
            categoriesRef.child($0.name).setValue($0.convertToDictionaty())
        }
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        categoriesRef.observe(.value) { snapshot in
            let categories = snapshot.children.compactMap { Category(snapshot: $0 as? DataSnapshot ?? DataSnapshot()) }
            completion(categories)
        }
    }
}
