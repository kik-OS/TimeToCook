//
//  InstructionPageControl.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 15.09.2021.
//

import UIKit

final class InstructionPageControl: UIPageControl {

    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        currentPage = 0
        numberOfPages = 7
        pageIndicatorTintColor = #colorLiteral(red: 0.9052640077, green: 0.9052640077, blue: 0.9052640077, alpha: 1)
        currentPageIndicatorTintColor = VarkaColors.mainColor
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
