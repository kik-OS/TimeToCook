//
//  RecentProductCollectionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import UIKit

final class RecentProductCollectionView: UICollectionView {
    
    // MARK: - Dependences
    
   private var viewModel: RecentProductCollectionViewViewModelProtocol

    // MARK: - Initializer 
    
    init(viewModel: RecentProductCollectionViewViewModelProtocol) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        viewModel.needUpdate = { [weak self] in
            self?.reloadData()
        }
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

    func setDelegate(delegate: RecentProductCollectionViewDelegate) {
        viewModel.delegate = delegate
    }

    var contentIsEmpty: Bool {
        viewModel.contentIsEmpty
    }
}

// MARK: - Extension

extension RecentProductCollectionView: UICollectionViewDelegate,
                                       UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentProductCollectionViewCell.reuseID,
                                       for: indexPath) as? RecentProductCollectionViewCell
        cell?.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width * 0.7, height: frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
}
