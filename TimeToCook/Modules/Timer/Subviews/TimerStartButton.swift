//
//  StartTimerButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import UIKit

final class TimerStartButton: UIButton {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        titleLabel?.textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Старт", for: .normal)
        accessibilityLabel = "startTimer"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 2
        backgroundColor = isEnabled
            ? UIConstants.startTimerButtonEnabledColor
            : UIConstants.startTimerButtonDisabledColor
    }
}
