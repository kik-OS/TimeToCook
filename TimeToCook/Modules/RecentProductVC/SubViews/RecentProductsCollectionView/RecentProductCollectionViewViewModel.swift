//
//  RecentProductCollectionViewViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation
import CoreData

// MARK: Protocol

protocol RecentProductCollectionViewViewModelProtocol: AnyObject {

    var delegate: RecentProductCollectionViewDelegate? { get set }
    var needUpdate: (() -> Void)? { get set }
    var contentIsEmpty: Bool { get }

    init(storageService: StorageServiceProtocol)

    func didSelectItemAt(indexPath: IndexPath)
    func numberOfItemsInSection(section: Int) -> Int
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol?
}

// MARK: Class

final class RecentProductCollectionViewViewModel: NSObject, RecentProductCollectionViewViewModelProtocol {

    // MARK: Properties

    var needUpdate: (() -> Void)?

    lazy var fetchResultController: NSFetchedResultsController<MOProduct> = {
        let fetchResultController = storageService.productFRC
        fetchResultController.delegate = self
        return fetchResultController
    }()

    var contentIsEmpty: Bool {
        let objects = fetchResultController.fetchedObjects
        guard let nonOptionalObjects = objects else { return true }
        return nonOptionalObjects.isEmpty
    }

    // MARK: Dependences

    private let storageService: StorageServiceProtocol
    weak var delegate: RecentProductCollectionViewDelegate?

    // MARK: - Init

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    // MARK: - Methods

    func didSelectItem(product: ProductDTO) {
        delegate?.presentInfoAboutProduct(product: Product(width: product))
    }

    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol? {
        let product = fetchResultController.object(at: indexPath)
        return RecentProductCollectionViewCellViewModel(product: product)
    }

    func didSelectItemAt(indexPath: IndexPath) {
        let MOProduct = fetchResultController.object(at: indexPath)
        let productDTO = ProductDTO(with: MOProduct)
        delegate?.presentInfoAboutProduct(product: Product(width: productDTO))
    }

    func numberOfItemsInSection(section: Int) -> Int {
        guard let sections = fetchResultController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
}

// MARK: - Extension

extension RecentProductCollectionViewViewModel: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        needUpdate?()
    }
}
