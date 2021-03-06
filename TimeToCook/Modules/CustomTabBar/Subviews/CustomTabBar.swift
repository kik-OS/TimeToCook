//
//  CustomTabBar.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit

final class CustomTabBar: UITabBar {

    // MARK: Properties
    
    private var shapeLayer: CALayer?
    private var deviceManagerService: DeviceServiceProtocol

    // MARK: Init

    init(deviceManagerService: DeviceServiceProtocol) {
        self.deviceManagerService = deviceManagerService
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func addShape(screenIsSquare: Bool) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = CGPath.createTabBarPath(frame: frame, screenIsSquare: screenIsSquare)
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowOpacity = 0.2
        shapeLayer.shadowColor = #colorLiteral(red: 0.249324028, green: 0.249324028, blue: 0.249324028, alpha: 1)
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    override func draw(_ rect: CGRect) {
        addShape(screenIsSquare: deviceManagerService.isSquareScreen)
    }
}
