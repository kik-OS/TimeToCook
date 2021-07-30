//
//  MascotImageView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 30.07.2021.
//

import UIKit

final class MascotImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "mascot.png")
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        setContentHuggingPriority(.init(252), for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
