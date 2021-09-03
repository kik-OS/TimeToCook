//
//  UIView+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 28.08.2021.
//

import UIKit

extension UIView {
    
    func appear(fromValue: CGFloat = 0, toValue: CGFloat = 1,
                duration: Double = 0.5, completion: @escaping (() -> Void) = {}) {
        isHidden = false
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
                completion()
            }
        }
    }
    
    func disappear(fromValue: CGFloat = 1, toValue: CGFloat = 0,
                   duration: Double = 0.5, completion: @escaping (() -> Void) = {}) {
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
                self.isHidden = true
                completion()
            }
        }
    }
    
    func shakeView() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 5, -5, 2, -2, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625 ]
        animation.duration = 0.3
        animation.isAdditive = true
        layer.add(animation, forKey: "shake")
    }

    func appearStartCookButtonAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 1,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
            }
        )
    }

    func appearTimerButtonAnimation() {
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

    func addVerticalGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor, #colorLiteral(red: 0.938239575, green: 0.938239575, blue: 0.938239575, alpha: 1).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }

    func appearCloseButtonAnimation() {
        UIView.animate(
            withDuration: 0.5, delay: 0.8,
            usingSpringWithDamping: 0.55,
            initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
            }
        )
    }

    func appearMascotAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
    }
}
