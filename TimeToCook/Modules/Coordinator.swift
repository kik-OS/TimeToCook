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

    private var customTabBarViewModel: TabBarViewModelProtocol {
        TabBarViewModel(notificationService: notificationService,
                        firebaseService: firebaseService,
                        storageManager: storageService,
                        deviceService: deviceService,
                        timerService: timerService)
    }

    init(window: UIWindow) {
        self.window = window
        firebaseService = FirebaseService()
        storageService = StorageService(coreDataStack: CoreDataStack.shared)
        timerService = TimerService()
        deviceService = DeviceService()
        notificationService = NotificationService()

        notificationService.notificationCenter.delegate = notificationService
        notificationService.requestAuthorization()
        notificationService.cleanBadgesAtStarting()
        start()
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
//        storageService
    }

}
