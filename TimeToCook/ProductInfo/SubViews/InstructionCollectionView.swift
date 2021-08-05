//
//  instructionCollectionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit

final class InstructionCollectionView: UICollectionView {
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        decelerationRate = .fast
        isPagingEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        register(ProductInfoCollectionViewCell.self, forCellWithReuseIdentifier: "instructionCell")
        clipsToBounds = false
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func createLayout(width: CGFloat) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width - 40, height: bounds.height - 40)
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .horizontal
        collectionViewLayout = layout
    }
}
