//
//  CustomTabBarViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 15.08.2021.
//

import UIKit

// MARK: Protocol

protocol TabBarViewModelProtocol: AnyObject {
    /// Вызывается в случае успешного получения продукта из базы. В параметр передаётся полученный из базы продукт.
    var productDidReceive: ((_ product: ProductProtocol) -> Void)? { get set }
    /// Вызывается для предложения добавить товар. В параметр передаётся бар-код, полученный от сканера.
    var addingNewProductOffer: ((_ code: String) -> Void)? { get set }
    /// Вызывается при каждом шаге таймера.
    var timerDidStep: ((_ time: String) -> Void)? { get set }
    var constantForMiddleButton: Float { get }
    var sizeForMiddleButton: Float { get }
    func findProduct(byCode code: String)
    func getProductInfoViewModel(product: ProductProtocol?) -> ProductInfoViewModelProtocol
    func getRecentProductViewModel() -> RecentProductViewModelProtocol
    func getAddingNewProductViewModel(withCode code: String) -> AddingNewProductViewModelProtocol
    func getTimerViewModel() -> TimerViewModelProtocol
    func createCustomTabBar() -> CustomTabBar
}

final class TabBarViewModel: TabBarViewModelProtocol {

    // MARK: Services

    private var notificationService: NotificationServiceProtocol
    private let firebaseService: FirebaseServiceProtocol
    private let storageService: StorageServiceProtocol
    private let deviceService: DeviceServiceProtocol
    private var timerService: TimerServiceProtocol

    // MARK: - Properties

    var productDidReceive: ((_ product: ProductProtocol) -> Void)?
    var addingNewProductOffer: ((_ code: String) -> Void)?
    var timerDidStep: ((_ time: String) -> Void)?
    var constantForMiddleButton: Float {
        deviceService.checkSquareScreen() ? 0 : 10
    }
    var sizeForMiddleButton: Float {
        deviceService.checkSquareScreen() ? 68 : 72
    }

    // MARK: - Initializers
    
    init(notificationService: NotificationServiceProtocol,
         firebaseService: FirebaseServiceProtocol,
         storageManager: StorageServiceProtocol,
         deviceService: DeviceServiceProtocol,
         timerService: TimerServiceProtocol) {
        self.notificationService = notificationService
        self.firebaseService = firebaseService
        self.storageService = storageManager
        self.deviceService = deviceService
        self.timerService = timerService
        self.timerService.barDelegate = self
        createTemporaryProductForDemonstration()
        downloadFromCD()
    }
    
    // MARK: - Public methods
    
    func findProduct(byCode code: String) {
        firebaseService.fetchProduct(byCode: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let product):
                self.productDidReceive?(product)
                self.createProductInCoreData(product: product)
            case .failure(let error):
                print(error.localizedDescription)
                self.addingNewProductOffer?(code)
            }
        }
    }

    func createCustomTabBar() -> CustomTabBar {
        CustomTabBar(deviceManagerService: deviceService)
    }

    func getProductInfoViewModel(product: ProductProtocol?) -> ProductInfoViewModelProtocol {
        ProductInfoViewModel(product: product,
                             timerService: timerService,
                             notificationService: notificationService)
    }
    
    func getRecentProductViewModel() -> RecentProductViewModelProtocol {
        RecentProductViewModel(storageService: storageService)
    }
    
    func getAddingNewProductViewModel(withCode code: String) -> AddingNewProductViewModelProtocol {
        AddingNewProductViewModel(code: code,
                                  firebaseService: firebaseService,
                                  notificationService: notificationService)
    }
    
    func getTimerViewModel() -> TimerViewModelProtocol {
        TimerViewModel(timerService: timerService,
                       notificationService: notificationService)
    }
    
    // MARK: - Private methods
    
    private func createProductInCoreData(product: ProductProtocol) {
        storageService.update(product: [ProductDTO(with: product)])
        //        storageService.saveProductCD(product: product)
    }


    /// Метод для демонстрации работы приложения, его здесь быть не должно
    func createTemporaryProductForDemonstration() {

        let products: [ProductDTO] = [ProductDTO(with: Product(code: "21121909098", title: "Макароны",
                                                               producer: "Макфа", category: "Макароны",
                                                               weight: 20, cookingTime: 10,
                                                               intoBoilingWater: true,
                                                               needStirring: true, waterRatio: 3)),
                                      ProductDTO(with: Product(code: "3332156464", title: "Вареники с вишней",
                                                               producer: "ВкусВилл", category: "Вареники",
                                                               weight: 1000, cookingTime: 7,
                                                               intoBoilingWater: true,
                                                               needStirring: true, waterRatio: 5)),
                                      ProductDTO(with: Product(code: "21121453543", title: "Гречка Русская",
                                                               producer: "Макфа", category: "Гречка",
                                                               weight: 500, cookingTime: 20,
                                                               intoBoilingWater: true,
                                                               needStirring: true, waterRatio: 3))]

        storageService.update(product: products)
        

    }

    func downloadFromCD() {
        let products = storageService.allProduct()
        print(products)
    }
}



extension TabBarViewModel: TimerServiceBarDelegate {
    
    func timerDidStep(remainingSeconds: Int, isStopped: Bool) {
        timerDidStep?(isStopped ? "" : remainingSeconds.getStringTimeOfTimer())
    }
}
