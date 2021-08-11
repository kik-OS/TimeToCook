//
//  SceneDelegate.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 20.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabBar = CustomTabBarController()
            let navigationController = CustomNavigationController(rootViewController: tabBar)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        TimerManager.shared.readSavedTime()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        TimerManager.shared.saveTime()
        StorageManager.shared.saveContext()
    }
}
