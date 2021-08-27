//
//  middleButtonTabBar.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 18.08.2021.
//

import UIKit

final class TabBarMiddleButton: UIButton {

    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = VarkaColors.mainColor
        layer.cornerRadius = frame.width / 2
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setImage(UIImage(systemName: ImageTitles.tabBarMiddleButton),
                 for: .normal)
        setPreferredSymbolConfiguration(
            UIImage.SymbolConfiguration(pointSize: 39, weight: .thin),
            forImageIn: .normal)
        animationForMiddleButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
