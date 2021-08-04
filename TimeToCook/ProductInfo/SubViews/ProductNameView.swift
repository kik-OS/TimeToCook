//
//  ProductNameView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.08.2021.
//

import UIKit

final class ProductNameLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        font = UIFont.preferredFont(forTextStyle: .title2)
        textColor = VarkaColors.mainColor
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        numberOfLines = 0
        minimumScaleFactor = 0.5
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setName(name: String) {
        text = name
    }
}
