//
//  AppDelegate.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 20.07.2021.
//

import Firebase
import FirebaseAuth
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Proterties
    
    private let notifications = Notifications()
    
    // MARK: - App lifecycle methods
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        notifications.notificationCenter.delegate = notifications
        notifications.requestAuthorization()
        notifications.cleanBadgesAtStarting()
        
        authenticateAnonymously()
        return true
    }
    
    // MARK: Scene lifecycle methods
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // MARK: - Private methods
    
    private func authenticateAnonymously() {
        Auth.auth().signInAnonymously { authDataResult, error in
            if let error = error {
                print("Anonymously sign in error:", error.localizedDescription)
                return
            }
            if authDataResult != nil {
                print("Anonymously sign in is successful!")
            }
        }
    }
}
