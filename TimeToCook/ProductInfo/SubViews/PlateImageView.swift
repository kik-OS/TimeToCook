//
//  PlateImageView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 29.07.2021.
//

import UIKit

final class PlateImageView: UIImageView {
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        image = UIImage(named: "plate")
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
