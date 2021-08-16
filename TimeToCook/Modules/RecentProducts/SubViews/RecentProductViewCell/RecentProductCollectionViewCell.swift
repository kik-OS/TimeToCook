//
//  RecentProductCollectionViewCell.swift
//  VarkaAPP
//
//  Created by Никита Гвоздиков on 10.03.2021.
//

import UIKit

final class RecentProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseID = Inscriptions.recentProductCollectionViewCellId
    
    // MARK: - Dependences
    
    var viewModel: RecentProductCollectionViewCellViewModelProtocol! {
        didSet {
            mainImageView.image = UIImage(named: viewModel.productImage)
            nameLabel.text = viewModel.productTitle
            producerLabel.text = viewModel.productProducer
            cookingTimeLabel.text = viewModel.productCookingTime
            barcodeLabel.text = viewModel.productBarcode
            weightLabel.text = viewModel.productWeight
        }
    }
    
    // MARK: - UI
    
   private lazy var mainImageView: MainImageRPCell = {
        let imageView = MainImageRPCell()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Regular", size: 20)
        label.textColor = VarkaColors.mainColor
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var barcodeLabel: SmallLabelCell = {
        let label = SmallLabelCell()
        return label
    }()
    
    private lazy var producerLabel: SmallLabelCell = {
        let label = SmallLabelCell()
        return label
    }()
    
    private lazy var weightLabel: SmallLabelCell = {
        let label = SmallLabelCell()
        return label
    }()
    
    private lazy var cookingTimeLabel: SmallLabelCell = {
        let label = SmallLabelCell()
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupAllConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.shadowOffset = CGSize(width: 0, height: 0)
        clipsToBounds = false
    }
    
    private func setupAllConstraint() {
        setupMainImageViewConstraint()
        setupNameLabelConstraints()
        setupBarcodeLabelConstraints()
        setupProducerLabelConstraints()
        setupWeightLabelConstraints()
        setupCookingTimeLabelConstraints()
    }
    
    private func setupMainImageViewConstraint() {
        addSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: topAnchor, constant: -25),
            mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/1.7)])
    }
    
    private func setupNameLabelConstraints() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 12)])
    }
    
    private func setupBarcodeLabelConstraints() {
        addSubview(barcodeLabel)
        NSLayoutConstraint.activate([
            barcodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            barcodeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            barcodeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: 10)])
    }
    
    private func setupProducerLabelConstraints() {
        addSubview(producerLabel)
        NSLayoutConstraint.activate([
            producerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            producerLabel.topAnchor.constraint(equalTo: barcodeLabel.bottomAnchor, constant: 4),
            producerLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: 10)])
    }
    
    private func setupWeightLabelConstraints() {
        addSubview(weightLabel)
        NSLayoutConstraint.activate([
            weightLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weightLabel.topAnchor.constraint(equalTo: producerLabel.bottomAnchor, constant: 4),
            weightLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2, constant: 10)])
    }
    
    private func setupCookingTimeLabelConstraints() {
        addSubview(cookingTimeLabel)
        NSLayoutConstraint.activate([
            cookingTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cookingTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            cookingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
}
