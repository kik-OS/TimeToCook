//
//  SingleStackView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 03.08.2021.
//

import UIKit

final class SingleStackView: UIStackView {
    
    // MARK: UI
    
    private lazy var title: UILabel = {
        let description = UILabel()
        description.text = "Заголовок"
        description.setContentHuggingPriority(.init(253), for: .horizontal)
        description.numberOfLines = 0
        description.minimumScaleFactor = 0.8
        description.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        description.adjustsFontSizeToFitWidth = true
        description.font = description.font.bold
        return description
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Основной текст"
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.8
        label.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.horizontal
        distribution = UIStackView.Distribution.fill
        contentMode = .scaleToFill
        alignment = UIStackView.Alignment.fill
        spacing = 0
        addArrangedSubview(title)
        addArrangedSubview(label)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setTitle(title: String) {
        self.title.text = title
    }
    
    func setLabel(label: String) {
        self.label.text = label
    }
}
