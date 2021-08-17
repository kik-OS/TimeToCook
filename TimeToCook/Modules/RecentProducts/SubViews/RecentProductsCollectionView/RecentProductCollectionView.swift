//
//  RecentProductCollectionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import UIKit

final class RecentProductCollectionView: UICollectionView {
    
    // MARK: - Dependences
    
    var viewModel: RecentProductCollectionViewViewModelProtocol! {
        didSet {
            viewModel.fetchProductFromCoreData { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    // MARK: - Initializer 
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        register(RecentProductCollectionViewCell.self,
                 forCellWithReuseIdentifier: RecentProductCollectionViewCell.reuseID)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = ConstantsCollectionView.productsCollectionMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 20, left: ConstantsCollectionView.leftDistanceToView,
                                    bottom: 0, right: ConstantsCollectionView.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension

extension RecentProductCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentProductCollectionViewCell.reuseID, for: indexPath) as! RecentProductCollectionViewCell
        cell.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width * 0.7, height: frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
}
