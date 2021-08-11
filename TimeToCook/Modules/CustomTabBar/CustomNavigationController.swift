//
//  CustomNavigationController.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 09.08.2021.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: VarkaColors.mainColor]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
