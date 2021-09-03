//
//  CloseButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 06.08.2021.
//

import UIKit

final class CloseButton: UIButton {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: "xmark"), for: .normal)
        tintColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        clipsToBounds = false
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
