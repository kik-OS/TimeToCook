//
//  ProductDTO.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 31.08.2021.
//

import Foundation

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
}
