//
//  RecentProductLabel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import UIKit

final class RecentProductLabel: UILabel {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        numberOfLines = 0
        font = font.withSize(25)
        textColor = .systemGray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
