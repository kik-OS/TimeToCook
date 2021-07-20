//
//  SceneDelegate.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 20.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneWillEnterForeground(_ scene: UIScene) {
        TimerManager.shared.readSavedTime()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        TimerManager.shared.saveTime()
        StorageManager.shared.saveContext()
    }
}
