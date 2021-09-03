//
//  TimerLabel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import UIKit

final class TimerLabel: UILabel {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        text = "Таймер"
        font = UIFont.preferredFont(forTextStyle: .title2)
        textColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
