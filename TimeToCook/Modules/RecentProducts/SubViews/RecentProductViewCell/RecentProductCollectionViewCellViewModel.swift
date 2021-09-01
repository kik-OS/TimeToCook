//
//  RecentProductCollectionViewCellViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation

protocol RecentProductCollectionViewCellViewModelProtocol: AnyObject {
    var productTitle: String? { get }
    var productProducer: String? { get }
    var productImage: String { get }
    var productCookingTime: String? { get }
    var productBarcode: String { get }
    var productWeight: String { get }
    init(product: Product)
}

final class RecentProductCollectionViewCellViewModel: RecentProductCollectionViewCellViewModelProtocol {
    
    // MARK: - Properties
    
    private let product: Product
    
    var productWeight: String {
        "\(product.weight ?? 200) грамм"
    }
    
    var productBarcode: String {
        product.code 
    }
    
    var productTitle: String? {
        product.title
    }
    
    var productProducer: String? {
        product.producer
    }
    
    var productImage: String {
        "\(product.category).png"
    }
    
    var productCookingTime: String? {
        "\(product.cookingTime)мин.⏱"
    }
    
    // MARK: - Initializer
    
    init(product: Product) {
        self.product = product
    }
}
