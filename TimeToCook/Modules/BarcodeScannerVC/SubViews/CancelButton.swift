//
//  CancelButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit

final class CancelCameraButton: UIButton {
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("Отменить", for: .normal)
        backgroundColor = UIColor(white: 0, alpha: 0.3)
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
