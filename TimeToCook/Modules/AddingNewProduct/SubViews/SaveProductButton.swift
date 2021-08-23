//
//  SaveProductButton.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 08.08.2021.
//

import UIKit

final class SaveProductButton: UIButton {
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(#colorLiteral(red: 0.8823114769, green: 0.8823114769, blue: 0.8823114769, alpha: 1), for: .disabled)
        setTitleColor(VarkaColors.mainColor, for: .normal)
        setTitleColor(#colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1), for: .highlighted)
        setTitle("Сохранить", for: .normal)
        backgroundColor = .white
        clipsToBounds = false
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.25
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
