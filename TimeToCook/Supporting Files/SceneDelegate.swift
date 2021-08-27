//
//  SceneDelegate.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 20.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            coordinator = Coordinator(window: window)
            self.window = coordinator?.getWindow
        }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        coordinator?.sceneWillEnterForeground()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        coordinator?.sceneDidEnterBackground()
    }
}
