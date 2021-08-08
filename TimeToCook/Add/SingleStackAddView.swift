//
//  SingleStackAdd.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 07.08.2021.
//

import UIKit

final class SingleStackAddView: UIStackView {
    
    //MARK: UI
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = VarkaColors.mainColor
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentHuggingPriority(.init(250), for: .horizontal)
        return textField
    }()
    
    //MARK: Dependences
    
    private var viewModel: SingleStackAddViewModelProtocol?
    
    //MARK: Init
    
    init(viewModel: SingleStackAddViewModelProtocol) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        translatesAutoresizingMaskIntoConstraints = false
        axis = NSLayoutConstraint.Axis.vertical
        distribution = UIStackView.Distribution.fill
        contentMode = .scaleToFill
        alignment = UIStackView.Alignment.leading
        spacing = 8
        addArrangedSubview(label)
        addArrangedSubview(textField)
        setupTextField()
        setContentHuggingPriority(.init(250), for: .horizontal)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methodes
    
    private func setupTextField() {
        guard let viewModel = viewModel else { return }
        textField.tag = viewModel.tag
        label.text = viewModel.name
        textField.placeholder = viewModel.placeHolder
        textField.autocorrectionType = viewModel.autocorrectionType
        textField.keyboardType = viewModel.keyBoardType
        textField.returnKeyType = viewModel.returnKeyType
        textField.autocapitalizationType = .words
    }

    //MARK: Public Methodes
    
    func getTF() -> UITextField {
        textField
    }
    
  
}



