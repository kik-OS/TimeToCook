//
//  CancelButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 22.07.2021.
//

import UIKit
final class CancelCameraButton: UIButton {
    
    
   override init(frame: CGRect) {
    super.init(frame: frame)
    setTitle("Отменить", for: .normal)
    backgroundColor = .black.withAlphaComponent(0.3)
    layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
