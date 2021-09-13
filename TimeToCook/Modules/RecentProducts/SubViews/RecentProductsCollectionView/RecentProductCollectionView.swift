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
        backgroundColor = .clear
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        register(RecentProductCollectionViewCell.self,
                 forCellWithReuseIdentifier: RecentProductCollectionViewCell.reuseID)
        layout.minimumLineSpacing = ConstantsCollectionView.productsCollectionMinimumLineSpacing
        setupContentInset()
        setupViewModelBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var contentIsEmpty: Bool {
        viewModel.contentIsEmpty
    }

    func setDelegate(delegate: RecentProductCollectionViewDelegate) {
        viewModel.delegate = delegate
    }

    private func setupContentInset() {
        contentInset = UIEdgeInsets(top: 20,
                                    left: ConstantsCollectionView.leftDistanceToView,
                                    bottom: 0,
                                    right: ConstantsCollectionView.rightDistanceToView)
    }

    private func setupViewModelBinding() {
        viewModel.needUpdate = { [weak self] in
            self?.reloadData()
        }
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width * 0.7, height: frame.height * 0.8)
    }
}
