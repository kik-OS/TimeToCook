//
//  ProductDTO.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 31.08.2021.
//

import Foundation
/// Сущность для передачи данных в и из хранилища
struct ProductDTO {
    
    let category: String?
    let code: String
    let cookingTime: Int
    let date: Date?
    let intoBoilingWater: Bool
    let needsStirring: Bool
    let producer: String?
    let title: String?
    let waterRatio: Double
    let weight: Int

    init(with productCD: MOProduct) {
        category = productCD.category
        code = productCD.code ?? ""
        cookingTime = Int(productCD.cookingTime)
        title = productCD.title
        producer = productCD.producer
        weight = Int(productCD.weight)
        intoBoilingWater = productCD.intoBoilingWater
        waterRatio = productCD.waterRatio
        date = productCD.date
        needsStirring = productCD.needsStirring
    }

    init(width product: ProductProtocol) {
        category = product.category
        code = product.code
        cookingTime = Int(product.cookingTime)
        title = product.title
        producer = product.producer
        weight = Int(product.weight ?? 0)
        intoBoilingWater = product.intoBoilingWater ?? true
        waterRatio = product.waterRatio
        date = Date()
        needsStirring = true
    }
}
