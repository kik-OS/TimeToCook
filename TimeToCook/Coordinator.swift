//
//  Coordinator.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 24.08.2021.
//

import UIKit

//protocol CoordinatorProtocol {
////    var navigationController: UINavigationController { get set }
//    var window: UIWindow { get }
//    var firebaseService: FirebaseServiceProtocol { get }
//    var storageService: StorageServiceProtocol { get }
//    var timerService: TimerServiceProtocol { get }
//    func start()
//}

class Coordinator {

    private var window: UIWindow
    private var firebaseService: FirebaseServiceProtocol
    private var storageService: StorageServiceProtocol
    private var timerService: TimerServiceProtocol
    private var deviceManagerService: DeviceManagerService

    private var customTabBarViewModel: CustomTabBarViewModelProtocol {
        CustomTabBarViewModel(firebaseService: firebaseService,
                              storageManager: storageService,
                              deviceManagerService: deviceManagerService)
    }

    init(window: UIWindow) {
        self.window = window
        firebaseService = FirebaseService.shared
        storageService = StorageService.shared
        timerService = TimerService.shared
        deviceManagerService = DeviceManagerService()
        start()
    }

   private func start() {
        let tabBar = CustomTabBarController(viewModel: customTabBarViewModel)
        let navigationController = CustomNavigationController(rootViewController: tabBar)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    var getWindow: UIWindow {
        window
    }

}
