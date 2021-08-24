//
//  TimerPickerView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 16.08.2021.
//

import UIKit

final class TimerPickerView: UIPickerView {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Override
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        subviews.last?.backgroundColor = .clear
    }
}
