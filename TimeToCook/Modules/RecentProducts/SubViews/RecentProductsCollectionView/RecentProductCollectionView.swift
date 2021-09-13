//
//  RecentProductCollectionView.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 10.08.2021.
//

import UIKit
import CoreData

final class RecentProductCollectionView: UICollectionView {
    
    // MARK: - Dependences
    
   private var viewModel: RecentProductCollectionViewViewModelProtocol {
        didSet {
            viewModel.fetchProductFromCoreData { [weak self] in
                self?.reloadData()
            }
        }
    }

    private lazy var frc: NSFetchedResultsController<MOProduct> = {
        let request = NSFetchRequest<MOProduct>(entityName: "MOProduct")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MOProduct.date), ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: viewModel.getMainContext(),
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
        frc.delegate = self

        do {
            try? frc.performFetch()
        }

        return frc
    }()

    // MARK: - Initializer 
    
    init(viewModel: RecentProductCollectionViewViewModelProtocol) {
        self.viewModel = viewModel
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

    func setDelegate(delegate: RecentProductCollectionViewDelegate) {
        viewModel.delegate = delegate
    }

    func getViewModel() -> RecentProductCollectionViewViewModelProtocol {
        viewModel
    }
}

// MARK: - Extension

extension RecentProductCollectionView: UICollectionViewDelegate,
                                       UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = frc.sections else { return 0 }
        print(sections[section].numberOfObjects)
        return sections[section].numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentProductCollectionViewCell.reuseID,
                                       for: indexPath) as? RecentProductCollectionViewCell
        let product = ProductDTO(with: frc.object(at: indexPath))
        cell?.viewModel = RecentProductCollectionViewCellViewModel(product: Product(width: product))
//        cell?.viewModel = viewModel.cellViewModel(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width * 0.7, height: frame.height * 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = ProductDTO(with: frc.object(at: indexPath))

        viewModel.didSelectItem(product: product)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    
}

extension RecentProductCollectionView: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
       reloadData()
    }
}
