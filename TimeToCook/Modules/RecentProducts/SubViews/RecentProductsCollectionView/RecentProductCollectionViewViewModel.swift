//
//  RecentProductCollectionViewViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation
import CoreData

protocol RecentProductCollectionViewViewModelProtocol: AnyObject {

    var delegate: RecentProductCollectionViewDelegate? { get set }
    var needUpdate: (() -> Void)? { get set }
    var contentIsEmpty: Bool { get }

    init(storageService: StorageServiceProtocol)

    func didSelectItemAt(indexPath: IndexPath)
    func numberOfItemsInSection(section: Int) -> Int
    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol?
}

final class RecentProductCollectionViewViewModel: NSObject, RecentProductCollectionViewViewModelProtocol {


    private lazy var frc: NSFetchedResultsController<MOProduct> = {
        let request = NSFetchRequest<MOProduct>(entityName: "MOProduct")
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MOProduct.date), ascending: false)]
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: storageService.getMainContext(),
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
        frc.delegate = self

        do {
            try? frc.performFetch()
        }

        return frc
    }()

    var needUpdate: (() -> Void)?

    func didSelectItem(product: ProductDTO) {
    delegate?.presentInfoAboutProduct(product: Product(width: product))
    }

    // MARK: Dependences

    private let storageService: StorageServiceProtocol
    weak var delegate: RecentProductCollectionViewDelegate?

    // MARK: - Properties

//    var products: [ProductProtocol] = []
//    var numberOfItemsInSection: Int { products.count }

    // MARK: - Init

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    // MARK: - Methods

    func cellViewModel(at indexPath: IndexPath) -> RecentProductCollectionViewCellViewModelProtocol? {
        let product = frc.object(at: indexPath)
        return RecentProductCollectionViewCellViewModel(product: product)
    }

    var contentIsEmpty = true

    func didSelectItemAt(indexPath: IndexPath) {
        let MOProduct = frc.object(at: indexPath)
        let productDTO = ProductDTO(with: MOProduct)
        delegate?.presentInfoAboutProduct(product: Product(width: productDTO))
    }

    func getMainContext() -> NSManagedObjectContext {
        storageService.getMainContext()
    }

    func numberOfItemsInSection(section: Int) -> Int {
        guard let sections = frc.sections else { return 0 }
        contentIsEmpty = false
        return sections[section].numberOfObjects
    }
}

extension RecentProductCollectionViewViewModel: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        needUpdate?()
    }
}
