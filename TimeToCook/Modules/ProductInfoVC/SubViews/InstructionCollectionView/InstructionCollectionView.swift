//
//  instructionCollectionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 05.08.2021.
//

import UIKit

final class InstructionCollectionView: UICollectionView {
    
    // MARK: Properties
    
    private var width: CGFloat
    
    // MARK: Init
    
    init(width: CGFloat) {
        self.width = width
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        decelerationRate = .fast
        isPagingEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
        register(InstructionCollectionViewCell.self, forCellWithReuseIdentifier: "instructionCell")
        clipsToBounds = false
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func createLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: bounds.height)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionViewLayout = layout
    }
}
