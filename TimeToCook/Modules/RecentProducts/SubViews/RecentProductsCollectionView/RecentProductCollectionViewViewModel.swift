//
//  RecentProductCollectionViewViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation
import CoreData

protocol RecentProductCollectionViewViewModelProtocol: AnyObject {
    var numberOfItemsInSection: Int { get }
    var products: [ProductProtocol] { get }
    var delegate: RecentProductCollectionViewDelegate? { get set }

    init(storageService: StorageServiceProtocol)

    func fetchProductFromCoreData(completion: @escaping() -> Void)
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol?
    func didSelectItem(product: ProductDTO)
    func contentIsEmpty() -> Bool
    func getMainContext() -> NSManagedObjectContext
}

final class RecentProductCollectionViewViewModel: RecentProductCollectionViewViewModelProtocol {
    func didSelectItem(product: ProductDTO) {
    delegate?.presentInfoAboutProduct(product: Product(width: product))

    }


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
//        products = storageService.fetchProducts().map { Product(width: $0) }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol? {
        let product = products[indexPath.row]
        return RecentProductCollectionViewCellViewModel(product: product)
    }

    func contentIsEmpty() -> Bool {
//        numberOfItemsInSection == 0
        false
    }

//    func didSelectItemAt(indexPath: IndexPath) {
//        let product = products[indexPath.row]
//        delegate?.presentInfoAboutProduct(product: product)
//    }

    func getMainContext() -> NSManagedObjectContext {
        storageService.getMainContext()
    }
}
