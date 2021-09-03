//
//  ProductNameView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.08.2021.
//

import UIKit

final class ProductNameLabel: UILabel {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        font = UIFont.preferredFont(forTextStyle: .title2)
        textColor = VarkaColors.mainColor
        font = font.bold
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        numberOfLines = 1
        minimumScaleFactor = 0.8
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setName(name: String) {
        text = name
    }
}
