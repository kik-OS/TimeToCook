//
//  StorageManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 12.07.2021.
//

import CoreData

protocol StorageServiceProtocol {
    func fetchData() -> [ProductCD]
    func saveProductCD(product: ProductProtocol)
    func convertFromProductCDToProduct(productCD: ProductCD) -> ProductProtocol?
    func deleteProductCD(_ productCD: ProductCD)
    func saveContext()
    func createTemporaryProductForDemonstration()
}

final class StorageService: StorageServiceProtocol {

    // MARK: - Core Data stack
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TimeToCook")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Public methods
    
    func fetchData() -> [ProductCD] {
        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        
        do {
            return try viewContext.fetch(fetchRequest)
        } catch let error {
            print("Failed to fetch data", error)
            return []
        }
    }
    
    func saveProductCD(product: ProductProtocol) {
        fetchData().forEach { if $0.code == product.code { deleteProductCD($0) } }
        let productCD = ProductCD(context: viewContext)
        productCD.code = product.code
        productCD.title = product.title
        productCD.producer = product.producer
        productCD.category = product.category
        productCD.cookingTime = Int64(product.cookingTime)
        productCD.waterRatio = product.waterRatio
        productCD.date = Date()
        if let productWeight = product.weight,
           let productNeedStirring = product.needStirring,
           let productIntoBoilingWater = product.intoBoilingWater {
            productCD.weight = Int64(productWeight)
            productCD.needsStirring = productNeedStirring
            productCD.intoBoilingWater = productIntoBoilingWater
        }
        saveContext()
    }
    
    func convertFromProductCDToProduct(productCD: ProductCD) -> ProductProtocol? {
        guard let code = productCD.code,
              let title = productCD.title,
              let producer = productCD.producer,
              let category = productCD.category else { return nil }
        return Product(code: code, title: title, producer: producer,
                       category: category, weight: Int(productCD.weight),
                       cookingTime: Int(productCD.cookingTime),
                       intoBoilingWater: true, needStirring: productCD.needsStirring,
                       waterRatio: productCD.waterRatio)
    }
    
    func deleteProductCD(_ productCD: ProductCD) {
        viewContext.delete(productCD)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    /// Метод для демонстрации работы приложения, его здесь быть не должно
    func createTemporaryProductForDemonstration() {
        saveProductCD(product: Product(code: "21121909098", title: "Макароны",
                                                             producer: "Макфа", category: "Макароны",
                                                             weight: 20, cookingTime: 10,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 3))
        saveProductCD(product: Product(code: "3332156464", title: "Вареники с вишней",
                                                             producer: "ВкусВилл", category: "Вареники",
                                                             weight: 1000, cookingTime: 7,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 5))
        saveProductCD(product: Product(code: "21121453543", title: "Гречка Русская",
                                                             producer: "Макфа", category: "Гречка",
                                                             weight: 500, cookingTime: 20,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 3))
        saveProductCD(product: Product(code: "333219090", title: "Нут",
                                                             producer: "Макфа", category: "Бобовые",
                                                             weight: 200, cookingTime: 40,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 3))
        saveProductCD(product: Product(code: "938040340", title: "Пельмени-Экстра",
                                                             producer: "Мираторг", category: "Пельмени",
                                                             weight: 1000, cookingTime: 8,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 3))
        saveProductCD(product: Product(code: "943560000", title: "Пшено",
                                                             producer: "Увелка", category: "Каши",
                                                             weight: 500, cookingTime: 3,
                                                             intoBoilingWater: true,
                                                             needStirring: true, waterRatio: 3))
    }
}
