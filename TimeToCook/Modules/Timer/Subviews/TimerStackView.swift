//
//  TimerStackView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import UIKit

final class TimerStackView: UIStackView {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.horizontal
        distribution = UIStackView.Distribution.fill
        contentMode = .scaleToFill
        alignment = UIStackView.Alignment.fill
        spacing = -35
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
