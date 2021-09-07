//
//  TemporaryProducts.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 07.09.2021.
//

import Foundation

/// Это временный класс, создан для наполнения приложения данными и демонстрации работы.
final class TemporaryProducts {

    static let products = [ProductDTO(width: Product(code: "21121909098", title: "Макароны",
                                                     producer: "Макфа", category: "Макароны",
                                                     weight: 500, cookingTime: 10,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3)),

                           ProductDTO(width: Product(code: "3332156464", title: "Вареники с вишней",
                                                     producer: "ВкусВилл", category: "Вареники",
                                                     weight: 1000, cookingTime: 7,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 5)),

                           ProductDTO(width: Product(code: "21121453543", title: "Гречка Русская",
                                                     producer: "Макфа", category: "Гречка",
                                                     weight: 500, cookingTime: 20,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3)),

                           ProductDTO(width: Product(code: "7479008332", title: "Спагетти",
                                                     producer: "Barilla", category: "Спагетти",
                                                     weight: 400, cookingTime: 8,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3)),

                           ProductDTO(width: Product(code: "6527204433", title: "Фасоль красная",
                                                     producer: "Мистраль", category: "Бобовые",
                                                     weight: 1000, cookingTime: 40,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 5)),

                           ProductDTO(width: Product(code: "74649393345", title: "Пельмени с курицей",
                                                     producer: "ВкусВилл", category: "Пельмени",
                                                     weight: 1000, cookingTime: 8,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3)),

                           ProductDTO(width: Product(code: "74646333345", title: "Рис Жасмин",
                                                     producer: "Мистраль", category: "Рис",
                                                     weight: 500, cookingTime: 20,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3)),

                           ProductDTO(width: Product(code: "847739344440", title: "Геркулес",
                                                     producer: "Русский Продукт", category: "Каши",
                                                     weight: 500, cookingTime: 20,
                                                     intoBoilingWater: true,
                                                     needStirring: true, waterRatio: 3))]
}
