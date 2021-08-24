//
//  CustomTabBarViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 15.08.2021.
//

import UIKit

protocol CustomTabBarViewModelProtocol: AnyObject {
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
    func getAddingNewProductViewModel(withCode code: String) -> AddingNewProductViewModelProtocol?
    func getTimerViewModel() -> TimerViewModelProtocol
    func createCustomTabBar() -> CustomTabBar
}

final class CustomTabBarViewModel: CustomTabBarViewModelProtocol {
 
    // MARK: - Properties
    
    var productDidReceive: ((_ product: ProductProtocol) -> Void)?
    var addingNewProductOffer: ((_ code: String) -> Void)?
    var timerDidStep: ((_ time: String) -> Void)?
    var constantForMiddleButton: Float {
        deviceManagerService.checkSquareScreen() ? 0 : 10
    }
    var sizeForMiddleButton: Float {
        deviceManagerService.checkSquareScreen() ? 68 : 72
    }
    
    // MARK: Dependences
    
    private let firebaseService: FirebaseServiceProtocol
    private let storageManager: StorageServiceProtocol
    private let deviceManagerService: DeviceManagerServiceProtocol
    
    // MARK: - Initializers
    
    init(firebaseService: FirebaseServiceProtocol,
         storageManager: StorageServiceProtocol,
         deviceManagerService: DeviceManagerServiceProtocol) {
        self.firebaseService = firebaseService
        self.storageManager = storageManager
        self.deviceManagerService = deviceManagerService
        TimerService.shared.barDelegate = self
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
        CustomTabBar(deviceManagerService: deviceManagerService)
    }

    func getProductInfoViewModel(product: ProductProtocol?) -> ProductInfoViewModelProtocol {
        ProductInfoViewModel(product: product)
    }
    
    func getRecentProductViewModel() -> RecentProductViewModelProtocol {
        RecentProductViewModel()
    }
    
    func getAddingNewProductViewModel(withCode code: String) -> AddingNewProductViewModelProtocol? {
      AddingNewProductViewModel(code: code, firebaseService: firebaseService)
    }
    
    func getTimerViewModel() -> TimerViewModelProtocol {
        TimerViewModel()
    }
    
    // MARK: - Private methods
    
    private func createProductInCoreData(product: ProductProtocol) {
        storageManager.saveProductCD(product: product)
    }
}

extension CustomTabBarViewModel: TimerServiceBarDelegate {
    
    func timerDidStep(remainingSeconds: Int, isStopped: Bool) {
        timerDidStep?(isStopped ? "" : remainingSeconds.getStringTimeOfTimer())
    }
}
