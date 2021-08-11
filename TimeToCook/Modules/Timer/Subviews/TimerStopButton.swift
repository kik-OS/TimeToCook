//
//  TimerStopButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import UIKit

final class TimerStopButton: UIButton {
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        titleLabel?.textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Стоп", for: .normal)
        backgroundColor = VarkaColors.mainColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = layer.frame.height / 2
    }
}
