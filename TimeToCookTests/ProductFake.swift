//
//  ProductFake.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 20.08.2021.
//

import Foundation

class ProductFake: ProductProtocol {
    var weight: Int? = 200
    var code = "12345678"
    var title = "Title"
    var producer = "Producer"
    var category = "Рис"
    var cookingTime = 20
    var intoBoilingWater: Bool?
    var needStirring: Bool?
    var waterRatio = 3.0
}
