//
//  UIPageControl+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 15.09.2021.
//

import UIKit

extension UIPageControl {

    func appearPageControlAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 0.5,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
            }
        )
    }
}
