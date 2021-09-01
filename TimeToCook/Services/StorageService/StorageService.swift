import Foundation
import CoreData

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
                    print("ПЕрешел в елсе")
                    let productCD = MOProduct(context: context)
                    productCD.configNew(with: $0)
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
        let fetchRequest = NSFetchRequest<MOProduct>(entityName: stack.entityName)
        context.performAndWait {
            let product = try? fetchRequest.execute()
            product?.forEach {
                context.delete($0)
            }
            stack.saveContext()
        }
    }

    func allProduct() -> [ProductDTO] {
        let context = stack.mainContext
        var result = [ProductDTO]()

        let request = NSFetchRequest<MOProduct>(entityName: stack.entityName)
        context.performAndWait {
            guard let product = try? request.execute() else { return }
            result = product.map { ProductDTO(with: $0) }
        }

        return result
    }
}

private extension StorageService {
    func fetchRequest(for dto: ProductDTO) -> NSFetchRequest<MOProduct> {
        let request = NSFetchRequest<MOProduct>(entityName: stack.entityName)
        request.predicate = .init(format: "code == %@", dto.code)
        return request
    }
}

extension ProductDTO {
    init(with productCD: MOProduct) {
        category = productCD.category
        code = productCD.code ?? ""
        cookingTime = Int(productCD.cookingTime)
        title = productCD.title
        producer = productCD.producer
        weight = Int(productCD.weight)
        intoBoilingWater = productCD.intoBoilingWater
        waterRatio = productCD.waterRatio
        date = productCD.date
        needsStirring = productCD.needsStirring
    }
}

extension ProductDTO {
    init(with product: ProductProtocol) {
        category = product.category
        code = product.code
        cookingTime = Int(product.cookingTime)
        title = product.title
        producer = product.producer
        weight = Int(product.weight ?? 0)
        intoBoilingWater = product.intoBoilingWater ?? true
        waterRatio = product.waterRatio
        date = Date()
        needsStirring = true
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

        print(self)
    }

    func configNew(with productDTO: ProductDTO) {
        update(with: productDTO)
    }
}

protocol StorageServiceProtocol {
    init(coreDataStack: CoreDataStackProtocol)

    /// Update recipe in store, if it doesn't exist it will be stored
    /// - Parameter recipes: recipeDTOs
    func update(product: [ProductDTO])

    /// Delete from store
    /// - Parameter recipes: recipeDTOs
    func delete(product: [ProductDTO]?)

    /// Delete all recipes from store
    func deleteAll()

    /// Get all stored recipes
    func allProduct() -> [ProductDTO]
}

protocol CoreDataStackProtocol {
    var moduleName: String { get }
    var entityName: String { get }

    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }

    /// Save context to persistent store
    func saveContext()
}

extension CoreDataStackProtocol {
    func saveContext() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Ошибка сохранения бэкграунда ")
                NSLog(error.localizedDescription)
            }
        }
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("Ошибка созранения мэйна ")
                NSLog(error.localizedDescription)
            }
        }
    }
}

class CoreDataStack: CoreDataStackProtocol {
    static let shared = CoreDataStack()

    let moduleName = "TimeToCook"
    let entityName = "MOProduct"
    /// for reading
    let mainContext: NSManagedObjectContext
    /// for writing
    let backgroundContext: NSManagedObjectContext

    private var managedObjectModel: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "TimeToCook", withExtension: "momd") else {
            NSLog("MOMD url is nil")
            fatalError("CoreData MOMD is nil")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            NSLog("CoreData MOMD is nil")
            fatalError("CoreData MOMD is nil")
        }
        return model
    }()

    private var persistentStoreCoordinator: NSPersistentStoreCoordinator

    private init() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("\(moduleName).sqlite")
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        let storeType = NSSQLiteStoreType
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator.addPersistentStore(ofType: storeType,
                                               configurationName: nil,
                                               at: url,
                                               options: options)
        } catch {
            fatalError("cant add persistent store: \(error)")
        }

        persistentStoreCoordinator = coordinator
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = persistentStoreCoordinator

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = mainContext
    }
}

//
//  StorageManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 12.07.2021.
//

//import CoreData
//
//protocol StorageServiceProtocol {
//    func fetchData() -> [ProductCD]
//    func saveProductCD(product: ProductProtocol)
//    func convertFromProductCDToProduct(productCD: ProductCD) -> ProductProtocol?
//    func deleteProductCD(_ productCD: ProductCD)
//    func saveContext()
//    func createTemporaryProductForDemonstration()
//}
//
//final class StorageService: StorageServiceProtocol {
//
//    // MARK: - Core Data stack
//
//    private let persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "TimeToCook")
//        container.loadPersistentStores(completionHandler: { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    private var viewContext: NSManagedObjectContext {
//        persistentContainer.viewContext
//    }
//
//    // MARK: - Public methods
//
//    func fetchData() -> [ProductCD] {
//        let fetchRequest: NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
//
//        do {
//            return try viewContext.fetch(fetchRequest)
//        } catch let error {
//            print("Failed to fetch data", error)
//            return []
//        }
//    }
//
//    func saveProductCD(product: ProductProtocol) {
//        fetchData().forEach { if $0.code == product.code { deleteProductCD($0) } }
//        let productCD = ProductCD(context: viewContext)
//        productCD.code = product.code
//        productCD.title = product.title
//        productCD.producer = product.producer
//        productCD.category = product.category
//        productCD.cookingTime = Int64(product.cookingTime)
//        productCD.waterRatio = product.waterRatio
//        productCD.date = Date()
//        if let productWeight = product.weight,
//           let productNeedStirring = product.needStirring,
//           let productIntoBoilingWater = product.intoBoilingWater {
//            productCD.weight = Int64(productWeight)
//            productCD.needsStirring = productNeedStirring
//            productCD.intoBoilingWater = productIntoBoilingWater
//        }
//        saveContext()
//    }
//
//    func convertFromProductCDToProduct(productCD: ProductCD) -> ProductProtocol? {
//        guard let code = productCD.code,
//              let title = productCD.title,
//              let producer = productCD.producer,
//              let category = productCD.category else { return nil }
//        return Product(code: code, title: title, producer: producer,
//                       category: category, weight: Int(productCD.weight),
//                       cookingTime: Int(productCD.cookingTime),
//                       intoBoilingWater: true, needStirring: productCD.needsStirring,
//                       waterRatio: productCD.waterRatio)
//    }
//
//    func deleteProductCD(_ productCD: ProductCD) {
//        viewContext.delete(productCD)
//        saveContext()
//    }
//
//    // MARK: - Core Data Saving support
//
//    func saveContext() {
//        if viewContext.hasChanges {
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    /// Метод для демонстрации работы приложения, его здесь быть не должно
//    func createTemporaryProductForDemonstration() {
//        saveProductCD(product: Product(code: "21121909098", title: "Макароны",
//                                                             producer: "Макфа", category: "Макароны",
//                                                             weight: 20, cookingTime: 10,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 3))
//        saveProductCD(product: Product(code: "3332156464", title: "Вареники с вишней",
//                                                             producer: "ВкусВилл", category: "Вареники",
//                                                             weight: 1000, cookingTime: 7,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 5))
//        saveProductCD(product: Product(code: "21121453543", title: "Гречка Русская",
//                                                             producer: "Макфа", category: "Гречка",
//                                                             weight: 500, cookingTime: 20,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 3))
//        saveProductCD(product: Product(code: "333219090", title: "Нут",
//                                                             producer: "Макфа", category: "Бобовые",
//                                                             weight: 200, cookingTime: 40,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 3))
//        saveProductCD(product: Product(code: "938040340", title: "Пельмени-Экстра",
//                                                             producer: "Мираторг", category: "Пельмени",
//                                                             weight: 1000, cookingTime: 8,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 3))
//        saveProductCD(product: Product(code: "943560000", title: "Пшено",
//                                                             producer: "Увелка", category: "Каши",
//                                                             weight: 500, cookingTime: 3,
//                                                             intoBoilingWater: true,
//                                                             needStirring: true, waterRatio: 3))
//    }
//}





