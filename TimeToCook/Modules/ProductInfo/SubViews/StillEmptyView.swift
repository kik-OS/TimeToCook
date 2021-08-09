//
//  StillEmptyView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 30.07.2021.
//

import UIKit

final class StillEmptyView: UIStackView {
    
    //MARK: UI

    private lazy var stillEmptyLabels: StillEmptyLabels = {
        let stillEmptyLabels = StillEmptyLabels()
        return stillEmptyLabels
    }()
    
    private lazy var mascotImageView: MascotImageView = {
        let mascotImageView = MascotImageView()
        return mascotImageView
    }()
    
    //MARK: Init

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.vertical
        distribution = UIStackView.Distribution.fill
        spacing = 0
        addArrangedSubview(stillEmptyLabels)
        addArrangedSubview(mascotImageView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



