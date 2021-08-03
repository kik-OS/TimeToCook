//
//  ProductDescriptionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 03.08.2021.
//

import UIKit

final class ProductView: UIStackView {
    
    private lazy var barcodeSV: SingleStackView = {
        let barcodeSV = SingleStackView()
        barcodeSV.setTitle(title: "Barcode:")
        return barcodeSV
    }()
    
    private lazy var categorySV: SingleStackView = {
        let categorySV = SingleStackView()
        categorySV.setTitle(title: "Категория:")
        return categorySV
    }()
    
    private lazy var producerSV: SingleStackView = {
        let producerSV = SingleStackView()
        producerSV.setTitle(title: "Производитель:")
        return producerSV
    }()
    
    private lazy var weightSV: SingleStackView = {
        let weightSV = SingleStackView()
        weightSV.setTitle(title: "Вес:")
        return weightSV
    }()
    
    private lazy var timeSV: SingleStackView = {
        let timeSV = SingleStackView()
        timeSV.setTitle(title: "Время варки:")
        return timeSV
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.vertical
        distribution = UIStackView.Distribution.fillEqually
        alignment = UIStackView.Alignment.fill
        spacing = 0
        
        addArrangedSubview(barcodeSV)
        addArrangedSubview(categorySV)
        addArrangedSubview(producerSV)
        addArrangedSubview(weightSV)
        addArrangedSubview(timeSV)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
