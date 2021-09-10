//
//  NameLabelCell.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.09.2021.
//

import UIKit

final class NameLabelCell: UILabel {

    init() {
        super.init(frame: .zero)
        font = UIFont(name: "Avenir Next Regular", size: 20)
        textColor = VarkaColors.mainColor
        numberOfLines = 1
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
