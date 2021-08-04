//
//  ProductDescriptionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 03.08.2021.
//

import UIKit

final class ProductView: UIStackView {
    
    // MARK: UI
    
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
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.vertical
        distribution = UIStackView.Distribution.fillEqually
        alignment = UIStackView.Alignment.fill
        spacing = 4
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        addArrangedSubview(barcodeSV)
        addArrangedSubview(categorySV)
        addArrangedSubview(producerSV)
        addArrangedSubview(weightSV)
        addArrangedSubview(timeSV)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setBarcode(barcode: String) {
        barcodeSV.setLabel(label: barcode)
    }
    
    func setCategory(category: String) {
        categorySV.setLabel(label: category)
    }
    
    func setProducer(producer: String) {
        producerSV.setLabel(label: producer)
    }
    
    func setWeight(weight: String) {
        weightSV.setLabel(label: weight)
    }
    
    func setTime(time: String) {
        timeSV.setLabel(label: time)
    }
    
}
