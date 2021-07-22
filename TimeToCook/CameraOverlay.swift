//
//  CameraOverlay.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 21.07.2021.
//

import UIKit
final class CameraOverlay: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: 15, y: center.y - 90, width: frame.width - 30,
                                       height: 180), cornerWidth: 10, cornerHeight: 10)
        path.closeSubpath()
        
        let shape = CAShapeLayer()
        shape.path = path
        layer.addSublayer(shape)
        path.addRect(CGRect(origin: .zero, size: frame.size))
        
        let maskLayer = CAShapeLayer()
//        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        layer.mask = maskLayer
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
