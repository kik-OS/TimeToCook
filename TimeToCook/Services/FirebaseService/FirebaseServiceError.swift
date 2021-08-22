//
//  FirebaseServiceError.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 17.07.2021.
//

import Foundation

enum FirebaseServiceError: Error, LocalizedError {
    case productNotFound
    case modelInitializingError
    case productsNotFound
    
    var errorDescription: String? {
        switch self {
        case .productNotFound:
            return "По данному коду продукт в базе не найден"
        case .modelInitializingError:
            return "Ошибка при инициализации продукта"
        case .productsNotFound:
            return "Ни одного продукта не добавлено в базу"
        }
    }
}
