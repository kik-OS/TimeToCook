//
//  MascotSecondImageView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 03.09.2021.
//

import UIKit

final class MascotSecondImageView: UIImageView {

// MARK: Init

    init() {
        super.init(frame: .zero)
        image = UIImage(named: "mascot2.png")
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
