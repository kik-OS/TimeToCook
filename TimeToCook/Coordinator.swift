//
//  Coordinator.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 24.08.2021.
//

import UIKit

protocol CoordinatorProtocol {
//    var navigationController: UINavigationController { get set }
    func start()
}

class Coordinator {
    private var window: UIWindow

    private

    init(window: UIWindow) {
        self.window = window
        start()
    }


   private func start() {

        let tabBar = CustomTabBarController()
        let navigationController = CustomNavigationController(rootViewController: tabBar)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    var getWindow: UIWindow {
        window
    }

}
