//
//  UpButtonForKB.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 09.08.2021.
//

import UIKit

final class UpButtonForKB: UIBarButtonItem {
    
    override init() {
        super.init()
        tintColor = .white
        image = UIImage(systemName: ImageTitles.toolBarUpButton)
        style = .plain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
