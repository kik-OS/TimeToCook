//
//  RecentProductCollectionViewViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation

protocol RecentProductCollectionViewViewModelProtocol: AnyObject {
    var numberOfItemsInSection: Int { get }
    var productsCD: [ProductCD] { get }
    var delegate: RecentProductCollectionViewDelegate? { get set }
    func fetchProductFromCoreData(completion: @escaping() -> Void)
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol?
    func didSelectItemAt(indexPath: IndexPath)
    func contentIsEmpty() -> Bool
    init(storageService: StorageServiceProtocol)
}

final class RecentProductCollectionViewViewModel: RecentProductCollectionViewViewModelProtocol {
    func contentIsEmpty() -> Bool {
        numberOfItemsInSection == 0
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard let product = storageService.convertFromProductCDToProduct(
                productCD: productsCD[indexPath.row]) else { return }
        delegate?.presentInfoAboutProduct(product: product)
    }
    
    // MARK: - Properties
    
    weak var delegate: RecentProductCollectionViewDelegate?
    var productsCD: [ProductCD] = []
    var numberOfItemsInSection: Int {
        productsCD.count
    }

    // MARK: Dependences

    private let storageService: StorageServiceProtocol

    // MARK: - Init

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    // MARK: - Methods
    
    func fetchProductFromCoreData(completion: @escaping() -> Void) {
        productsCD = storageService.fetchData().sorted(by: { $0.date ?? Date() > $1.date ?? Date() })
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol? {
        let product = productsCD[indexPath.row]
        return RecentProductCollectionViewCellViewModel(product: product)
    }
}
