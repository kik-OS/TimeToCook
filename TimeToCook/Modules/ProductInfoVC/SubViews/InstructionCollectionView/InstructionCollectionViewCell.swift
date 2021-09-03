//
//  ProductInfoCollectionViewCell.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit

final class InstructionCollectionViewCell: UICollectionViewCell {
    
    // MARK: UI
    
    private lazy var numberOfCardLabel: UILabel = {
        let numberOfCardLabel = UILabel()
        numberOfCardLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCardLabel.textColor = .black
        numberOfCardLabel.numberOfLines = 0
        numberOfCardLabel.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        return numberOfCardLabel
    }()
    
    private lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.textColor = .black
        instructionLabel.numberOfLines = 0
        instructionLabel.setContentCompressionResistancePriority(.init(251), for: .vertical)
        instructionLabel.setContentHuggingPriority(.init(1), for: .vertical)
        instructionLabel.adjustsFontSizeToFitWidth = true
        instructionLabel.minimumScaleFactor = 0.5
        instructionLabel.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        return instructionLabel
    }()
    
    private lazy var nextLabel: UILabel = {
        let nextLabel = UILabel()
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        nextLabel.textColor = .black
        nextLabel.text = "→"
        nextLabel.textColor = #colorLiteral(red: 0.5570600033, green: 0.5567737818, blue: 0.5772830844, alpha: 1)
        return nextLabel
    }()
    
    private lazy var instructionImage: UIImageView = {
        let instructionImage = UIImageView()
        instructionImage.translatesAutoresizingMaskIntoConstraints = false
        instructionImage.layer.cornerRadius = 20
        instructionImage.clipsToBounds = true
        instructionImage.contentMode = .scaleAspectFit
        return instructionImage
    }()
    
    // MARK: Dependences
    
    private var viewModel: InstructionCollectionViewCellViewModelProtocol? {
        didSet {
            numberOfCardLabel.text = viewModel?.numberOfCard
            instructionImage.image = UIImage(named: viewModel?.instrImage ?? "")
            instructionLabel.text = viewModel?.getInstrLabel()
            nextLabel.isHidden = viewModel?.isShowNextLabel ?? true
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllConstraints()
        backgroundColor = .white
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.cornerRadius = 10
        clipsToBounds = false
    }
    
    // MARK: Private Methodes
    
    private func setupAllConstraints() {
        contentView.addSubview(instructionImage)
        contentView.addSubview(numberOfCardLabel)
        contentView.addSubview(instructionLabel)
        contentView.addSubview(nextLabel)
        setupInstructionImageConstraints()
        setupNumberOfCardLabelConstraints()
        setupInstructionLabelConstraints()
        setupNextLabelConstraints()
    }
    
    private func setupInstructionImageConstraints() {
        NSLayoutConstraint.activate([
            instructionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            instructionImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            instructionImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            instructionImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 3)])
    }
    
    private func setupNumberOfCardLabelConstraints() {
        NSLayoutConstraint.activate([
            numberOfCardLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            numberOfCardLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            numberOfCardLabel.bottomAnchor.constraint(equalTo: instructionLabel.topAnchor, constant: -8)])
    }
    
    private func setupInstructionLabelConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: instructionImage.trailingAnchor, constant: 8),
            instructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            instructionLabel.bottomAnchor.constraint(equalTo: nextLabel.topAnchor, constant: 8)])
    }
    
    private func setupNextLabelConstraints() {
        NSLayoutConstraint.activate([
            nextLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: -8),
            nextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
    }
    
    // MARK: Methods
    
    func setViewModel(viewModel: InstructionCollectionViewCellViewModelProtocol?) {
        self.viewModel = viewModel
    }
}
