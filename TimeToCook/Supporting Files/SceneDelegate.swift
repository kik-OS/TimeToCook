//
//  SceneDelegate.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 20.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let coordinator = Coordinator(window: UIWindow(windowScene: windowScene))
            window = coordinator.getWindow
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Hello")
        TimerService.shared.readSavedTime()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        TimerService.shared.saveTime()
        StorageService.shared.saveContext()
    }
}
