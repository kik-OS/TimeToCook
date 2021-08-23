//
//  StartCookButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit

final class StartCookButton: UIButton {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(#colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1), for: .normal)
        setTitleColor(VarkaColors.mainColor, for: .highlighted)
        backgroundColor = .white
        clipsToBounds = false
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.25
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func startState() {
        setTitle("Начать готовку", for: .normal)
    }
    
    func stopState() {
        setTitle("Закончить готовку", for: .normal)
    }
}
