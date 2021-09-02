//
//  RecentProductCollectionViewViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation

protocol RecentProductCollectionViewViewModelProtocol: AnyObject {
    var numberOfItemsInSection: Int { get }
    var products: [ProductProtocol] { get }
    var delegate: RecentProductCollectionViewDelegate? { get set }

    init(storageService: StorageServiceProtocol)

    func fetchProductFromCoreData(completion: @escaping() -> Void)
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol?
    func didSelectItemAt(indexPath: IndexPath)
    func contentIsEmpty() -> Bool
}

final class RecentProductCollectionViewViewModel: RecentProductCollectionViewViewModelProtocol {

    // MARK: Dependences

    private let storageService: StorageServiceProtocol
    weak var delegate: RecentProductCollectionViewDelegate?

    // MARK: - Properties

    var products: [ProductProtocol] = []
    var numberOfItemsInSection: Int { products.count }

    // MARK: - Init

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    // MARK: - Methods
    
    func fetchProductFromCoreData(completion: @escaping() -> Void) {
        /// Сортировка массива полученных данных по дате создания
        products = storageService.fetchProducts().sorted(by: {
            $0.date ?? Date() > $1.date ?? Date()
        }).map { Product(width: $0) }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol? {
        let product = products[indexPath.row]
        return RecentProductCollectionViewCellViewModel(product: product)
    }

    func contentIsEmpty() -> Bool {
        numberOfItemsInSection == 0
    }

    func didSelectItemAt(indexPath: IndexPath) {
        let product = products[indexPath.row]
        delegate?.presentInfoAboutProduct(product: product)
    }
}
