//
//  TimerBackgroundView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import UIKit

final class TimerBackgroundView: UIView {
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
