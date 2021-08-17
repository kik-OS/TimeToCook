//
//  MainImageRPCell.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 16.08.2021.
//

import UIKit

final class MainImageRPCell: UIImageView {
    
    // MARK: - Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 4, height: 4)
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
