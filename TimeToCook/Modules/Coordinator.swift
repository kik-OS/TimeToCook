//
//  Coordinator.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 24.08.2021.
//

import UIKit

final class Coordinator {

    private var window: UIWindow
    private var firebaseService: FirebaseServiceProtocol
    private var storageService: StorageServiceProtocol
    private var timerService: TimerServiceProtocol
    private var deviceService: DeviceServiceProtocol
    private var notificationService: NotificationService
    private var coreDataStack: CoreDataStackProtocol

    private var customTabBarViewModel: TabBarViewModelProtocol {
        TabBarViewModel(notificationService: notificationService,
                        firebaseService: firebaseService,
                        storageManager: storageService,
                        deviceService: deviceService,
                        timerService: timerService)
    }

    init(window: UIWindow) {
        self.window = window
        timerService = TimerService()
        deviceService = DeviceService()
        firebaseService = FirebaseService()
        coreDataStack = CoreDataStack.shared
        notificationService = NotificationService()
        storageService = StorageService(coreDataStack: coreDataStack)
        start()
    }

    var getWindow: UIWindow { window }
    
    private func start() {
        let tabBar = TabBarViewController(viewModel: customTabBarViewModel)
        let navigationController = CustomNavigationController(rootViewController: tabBar)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        if !hasBeenLaunchdBefore() {
            createTemporaryProductForDemonstration()
        }
    }
}

extension Coordinator {

    func sceneWillEnterForeground() {
        timerService.readSavedTime()
    }

    func sceneDidEnterBackground() {
        timerService.saveTime()
    }

    private func hasBeenLaunchdBefore() -> Bool {
        let userDefaults = UserDefaults.standard
        let key = "hasBeenLaunchdBeforeFlag"
        if userDefaults.bool(forKey: key) {
            return true
        } else {
            userDefaults.setValue(true, forKey: key)
            return false
        }
    }

    /// Метод для демонстрации работы приложения, его здесь быть не должно
    func createTemporaryProductForDemonstration() {
        storageService.update(product: TemporaryProducts.products)
    }
}
