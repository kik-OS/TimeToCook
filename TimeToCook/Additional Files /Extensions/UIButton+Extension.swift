//
//  UIButton+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 18.07.2021.
//

import UIKit

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.98
        pulse.toValue = 1
        pulse.duration = 5
        pulse.autoreverses = true
        pulse.repeatCount = Float.greatestFiniteMagnitude
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        layer.add(pulse, forKey: nil)
    }

    func animationForMiddleButton() {
        let rotation = CASpringAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 4)
        rotation.duration = 6
        rotation.mass = 1
        layer.add(rotation, forKey: nil)
    }

}
