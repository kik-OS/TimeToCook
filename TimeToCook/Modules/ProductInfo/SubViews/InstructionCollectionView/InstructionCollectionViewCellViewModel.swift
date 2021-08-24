//
//  ProductInfoCollectionViewCellViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import Foundation

protocol InstructionCollectionViewCellViewModelProtocol {
    var numberOfCard: String { get }
    var instrImage: String { get }
    var isShowNextLabel: Bool { get }
    init(product: ProductProtocol?, indexPath: IndexPath)
    func getInstrLabel() -> String
}

final class InstructionCollectionViewCellViewModel: InstructionCollectionViewCellViewModelProtocol {
    
    // MARK: Properties
    
    private let product: ProductProtocol?
    private let indexPath: IndexPath
    
    var isShowNextLabel: Bool {
        indexPath.row == 6
    }

    var instrImage: String {
        "instr\(indexPath.row)"
    }
    
    var numberOfCard: String {
        "\(indexPath.row + 1)"
    }
    
    func getInstrLabel() -> String {
        guard let product = product else { return "" }
        
        switch indexPath.row {
        case 0:
            return Inscriptions.instructionOfCookingFirstStep
        case 1:
            return "\(Inscriptions.instructionOfCookingSecondStep) \(Int(product.waterRatio)):1"
        case 2:
            return Inscriptions.instructionOfCookingThirdStep
        case 3:
            return Inscriptions.instructionOfCookingFourthStep
        case 4:
            return "Необходимо варить \(product.cookingTime)мин., периодически помешивая"
        case 5:
            return Inscriptions.instructionOfCookingFifthStep
        case 6:
            return Inscriptions.instructionOfCookingSixthStep
        default:
            return ""
        }
    }
    
    // MARK: - Initializer
    
    required init(product: ProductProtocol?, indexPath: IndexPath) {
        self.product = product
        self.indexPath = indexPath
    }
}
