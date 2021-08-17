//
//  SmallLabelCell.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 16.08.2021.
//

import UIKit

final class SmallLabelCell: UILabel {
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        font = UIFont(name: "Avenir Next Regular", size: 15)
        textColor = .systemGray
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
