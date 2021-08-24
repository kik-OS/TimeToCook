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
            return Inscriptions.productNotFoundError
        case .modelInitializingError:
            return Inscriptions.modelInitializingError
        case .productsNotFound:
            return Inscriptions.productsNotFoundError
        }
    }
}
