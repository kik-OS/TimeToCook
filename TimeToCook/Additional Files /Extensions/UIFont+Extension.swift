//
//  UIFont+Extension.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 04.08.2021.
//

import UIKit

extension UIFont {
    
    var bold: UIFont { with(.traitBold) }
    var italic: UIFont { with(.traitItalic) }
    var boldItalic: UIFont { with([.traitBold, .traitItalic]) }

    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(
                UIFontDescriptor.SymbolicTraits(traits).union(fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(
                fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
