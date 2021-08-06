//
//  ProductInfoCollectionViewCellViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import Foundation


import Foundation


protocol InstructionCollectionViewCellViewModelProtocol {
    var numberOfCard: String { get }
    var instrImage: String { get }
    var isShowNextLabel: Bool { get }
    func getInstrLabel() -> String
    init(product: Product?, indexPath: IndexPath)
    
}

class InstructionCollectionViewCellViewModel: InstructionCollectionViewCellViewModelProtocol {
    private let product: Product?
    private let indexPath: IndexPath
    
    var isShowNextLabel: Bool {
        switch indexPath.row {
        case 6:
           return true
        default :
            return false
        }
    }
    
    var instrImage: String {
        "instr\(indexPath.row)"
    }
    
    var numberOfCard: String {
        "\(indexPath.row + 1)"
    }
    
    func getInstrLabel() -> String {
        guard let product = product else {return ""}
        
        switch indexPath.row {
        case 0:
            return "Подготовьте продукты, начинаем готовить"
        case 1:
            return "Наполните кастрюлю водой, в соотношении с продуктом \(Int(product.waterRatio)):1"
        case 2:
            return "Дождитесь закипания воды"
        case 3:
            return "Опустите продукт в кипящую воду. Нажмите на таймер 👇🏻"
        case 4:
            return "Необходимо варить \(product.cookingTime)мин., периодически помешивая"
        case 5:
            return "Слейте воду"
        case 6:
            return "Добавьте по вкусу соль, перец, масло. Приятного аппетита!"
        default:
            return ""
        }
    }
    
    
    
    // MARK: - Initializer
    
    required init(product: Product?, indexPath: IndexPath) {
        self.product = product
        self.indexPath = indexPath
    }
    
}
