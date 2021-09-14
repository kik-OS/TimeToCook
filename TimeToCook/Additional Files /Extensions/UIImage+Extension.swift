//
//  UIImage+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 14.09.2021.
//

import UIKit

extension UIImage {

    func resizeToAspectFit(containerSize: CGSize) -> UIImage? {
        var newSize = containerSize
        let maxWidth = containerSize.width / size.width
        let maxHeight = containerSize.height / size.height

        maxHeight < maxWidth
            ? (newSize.width = containerSize.height / size.height * size.width)
            : (newSize.height = containerSize.width / size.width * size.height)

        let rect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
