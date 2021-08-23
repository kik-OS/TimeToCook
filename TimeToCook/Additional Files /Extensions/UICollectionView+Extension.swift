//
//  UICollectionView+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 23.08.2021.
//

import UIKit

extension UICollectionView {
    
   func appearCollectionViewAnimation() {
        reloadData()
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

  func collectionViewLayoutAnimation(velocity: CGPoint, point: CGPoint ) {
        UIView.animate(withDuration: 0.3, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: velocity.x,
                       options: .allowUserInteraction, animations: {
                        self.setContentOffset(point, animated: true)
                       }
        )
    }
}
