//
//  StillEmptyLabels.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 30.07.2021.
//

import UIKit

final class StillEmptyLabels: UIView {
    
    //MARK: UI
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Упс..."
        title.font = UIFont.preferredFont(forTextStyle: .title2)
        title.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        return title
    }()
    
    private lazy var message: UILabel = {
        let message = UILabel()
        message.text = Inscriptions.messageOfStillEmptyView
        message.numberOfLines = 0
        message.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.adjustsFontSizeToFitWidth = true
        message.minimumScaleFactor = 0.5
        return message
    }()
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setContentHuggingPriority(.init(253), for: .vertical)
        clipsToBounds = false
        layer.cornerRadius = 15
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methodes 
    
    private func setupConstraints() {
        addSubview(title)
        addSubview(message)
        title.setContentHuggingPriority(.init(252), for: .vertical)
        NSLayoutConstraint.activate([title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     title.topAnchor.constraint(equalTo: topAnchor, constant: 8)])
        
        NSLayoutConstraint.activate([message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     message.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     message.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
                                     message.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)])
    }
}
