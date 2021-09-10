//
//  StorageManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 12.07.2021.
//

import Foundation
import CoreData

// MARK: Protocol

protocol StorageServiceProtocol {
    init(coreDataStack: CoreDataStackProtocol)

    /// Обновить данные продукта или создать новый если не существует
    func update(product: [ProductDTO])

    /// Удалить конкретные продукты
    func delete(product: [ProductDTO]?)

    /// Удалить все продукты
    func deleteAll()

    /// Получить все продукты
    func fetchProducts() -> [ProductDTO]
}

final class StorageService {

    private let stack: CoreDataStackProtocol

    init(coreDataStack: CoreDataStackProtocol) {
        stack = coreDataStack
    }
}

extension StorageService: StorageServiceProtocol {

    func update(product: [ProductDTO]) {
        let context = stack.backgroundContext
        context.performAndWait {
            product.forEach {
                if let productCD = try? self.fetchRequest(for: $0).execute().first {
                    productCD.update(with: $0)
                } else {
                    let productCD = MOProduct(context: context)
                    productCD.update(with: $0)
                }
            }
            stack.saveContext()
        }
    }

    func delete(product: [ProductDTO]?) {
        let context = stack.backgroundContext
        context.performAndWait {
            product?.forEach {
                if let product = try? self.fetchRequest(for: $0).execute().first {
                    context.delete(product)
                }
            }
            stack.saveContext()
        }
    }

    func deleteAll() {
        let context = stack.backgroundContext
        let fetchRequest = NSFetchRequest<MOProduct>(entityName: stack.getEntity())
        context.performAndWait {
            let product = try? fetchRequest.execute()
            product?.forEach {
                context.delete($0)
            }
            stack.saveContext()
        }
    }

    func fetchProducts() -> [ProductDTO] {
        let context = stack.mainContext
        var result = [ProductDTO]()
        let request = NSFetchRequest<MOProduct>(entityName: stack.getEntity())
        /// Сортировка массива полученных данных по дате создания
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MOProduct.date), ascending: false)]
        context.performAndWait {
            guard let product = try? request.execute() else { return }
            result = product.map { ProductDTO(with: $0) }
        }
        return result
    }
}

private extension StorageService {
    func fetchRequest(for dto: ProductDTO) -> NSFetchRequest<MOProduct> {
        let request = NSFetchRequest<MOProduct>(entityName: stack.getEntity())
        request.predicate = .init(format: "code == %@", dto.code)
        return request
    }
}

fileprivate extension MOProduct {
    func update(with productDTO: ProductDTO) {
        code = productDTO.code
        title = productDTO.title ?? ""
        producer = productDTO.producer ?? ""
        category = productDTO.category ?? ""
        weight = Int64(productDTO.weight)
        cookingTime = Int64(productDTO.cookingTime)
        intoBoilingWater = productDTO.intoBoilingWater
        waterRatio = productDTO.waterRatio
        date = Date()
    }
}
