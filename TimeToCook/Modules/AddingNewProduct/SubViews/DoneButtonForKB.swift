//
//  DoneButtonForKB.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 09.08.2021.
//

import UIKit

final class DoneButtonForKB: UIBarButtonItem {
    
    //MARK: Init
    
    override init() {
        super.init()
        tintColor = .white
        isEnabled = false
        title = Inscriptions.titleOfDoneButtonForKB
        style = .plain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
