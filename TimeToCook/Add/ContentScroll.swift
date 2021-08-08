//
//  ContentScroll.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 07.08.2021.
//

import UIKit

final class ContentScroll: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        keyboardDismissMode = .interactive
        bounces = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
