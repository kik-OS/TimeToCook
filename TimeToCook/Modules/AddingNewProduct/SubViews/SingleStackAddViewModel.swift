//
//  SingleStackAddViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 08.08.2021.
//

import UIKit

enum TextFieldsType {
    case category
    case productLabel
    case producer
    case time
    case weight
    case waterRatio
}

protocol SingleStackAddViewModelProtocol {
    var tag: Int { get }
    var name: String { get }
    var placeHolder: String { get }
    var keyBoardType: UIKeyboardType { get }
    var autocorrectionType: UITextAutocorrectionType { get }
    var returnKeyType: UIReturnKeyType { get }
    init(textFieldType: TextFieldsType)
}


final class SingleStackAddViewModel: SingleStackAddViewModelProtocol {
    
    // MARK: Private Properties
    
    private var textFieldType: TextFieldsType
    
    // MARK: Public Properties
    
    var returnKeyType: UIReturnKeyType = .next
    var autocorrectionType: UITextAutocorrectionType = .default
    var keyBoardType: UIKeyboardType = .default
    var name = ""
    var placeHolder = ""
    var tag = 0
    
    // MARK: Init
    
    init(textFieldType: TextFieldsType) {
        self.textFieldType = textFieldType
        setup()
    }
    
    // MARK: Private Methodes
    
    private func setup() {
        switch textFieldType {
        case .category:
            name = "Категория Продукта"
            placeHolder = "Выбрать категорию"
        case .productLabel:
            name = "Название Продукта"
            placeHolder = "Рис Жасмин"
            tag = 1
        case .producer:
            name = "Производитель"
            placeHolder = "Мистраль"
            tag = 2
        case .time:
            name = "Время приготовления(мин.)"
            placeHolder = "15"
            tag = 3
            keyBoardType = .numberPad
        case .weight:
            name = "Количество(грамм.)"
            placeHolder = "400"
            tag = 4
            keyBoardType = .numberPad
        case .waterRatio:
            name = "Соотношение продукта к воде"
            placeHolder = "Выбрать"
            tag = 5
        }
    }
}

