//
//  Coordinator.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 24.08.2021.
//

import UIKit

class Coordinator {

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

        notificationService.notificationCenter.delegate = notificationService
        notificationService.requestAuthorization()
        notificationService.cleanBadgesAtStarting()
        start()
        createTemporaryProductForDemonstration()
    }

    var getWindow: UIWindow { window }
    
    private func start() {
        let tabBar = TabBarViewController(viewModel: customTabBarViewModel)
        let navigationController = CustomNavigationController(rootViewController: tabBar)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    func sceneWillEnterForeground() {
        timerService.readSavedTime()
    }

    func sceneDidEnterBackground() {
        timerService.saveTime()
    }
}

extension Coordinator {
    /// Метод для демонстрации работы приложения, его здесь быть не должно
    func createTemporaryProductForDemonstration() {
        let products: [ProductDTO] = [ProductDTO(width: Product(code: "21121909098", title: "Макароны",
                                                                producer: "Макфа", category: "Макароны",
                                                                weight: 500, cookingTime: 10,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3)),

                                      ProductDTO(width: Product(code: "3332156464", title: "Вареники с вишней",
                                                                producer: "ВкусВилл", category: "Вареники",
                                                                weight: 1000, cookingTime: 7,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 5)),

                                      ProductDTO(width: Product(code: "21121453543", title: "Гречка Русская",
                                                                producer: "Макфа", category: "Гречка",
                                                                weight: 500, cookingTime: 20,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3)),

                                      ProductDTO(width: Product(code: "7479008332", title: "Спагетти",
                                                                producer: "Barilla", category: "Спагетти",
                                                                weight: 400, cookingTime: 8,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3)),

                                      ProductDTO(width: Product(code: "6527204433", title: "Фасоль красная",
                                                                producer: "Мистраль", category: "Бобовые",
                                                                weight: 1000, cookingTime: 40,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 5)),

                                      ProductDTO(width: Product(code: "74649393345", title: "Пельмени с курицей",
                                                                producer: "ВкусВилл", category: "Пельмени",
                                                                weight: 1000, cookingTime: 8,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3)),

                                      ProductDTO(width: Product(code: "74646333345", title: "Рис Жасмин",
                                                                producer: "Мистраль", category: "Рис",
                                                                weight: 500, cookingTime: 20,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3)),

                                      ProductDTO(width: Product(code: "847739344440", title: "Геркулес",
                                                                producer: "Русский Продукт", category: "Каши",
                                                                weight: 500, cookingTime: 20,
                                                                intoBoilingWater: true,
                                                                needStirring: true, waterRatio: 3))]

        storageService.update(product: products)
    }
}
