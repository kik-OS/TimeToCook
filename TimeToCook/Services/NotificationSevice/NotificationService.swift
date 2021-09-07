//
//  Notifications.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 18.08.2021.
//

import UIKit
import UserNotifications

protocol NotificationServiceProtocol: AnyObject {
    func checkNotificationSettings(completion: @escaping () -> Void)
    func cleanBadgesAtStarting()
    func showTimerNotification(throughMinutes: Double)
    func showProductWasAddedNotification()
    func cancelTimerNotification()
    func notificationsAreNotAvailableAlert() -> UIAlertController
}

final class NotificationService: NSObject, UNUserNotificationCenterDelegate {

    // MARK: - Properties

    private var notificationCenter = UNUserNotificationCenter.current()

    private lazy var timerContent: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = Inscriptions.titleOfTimerNotification
        content.body = Inscriptions.bodyOfTimerNotification
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "not.wav"))
        content.badge = 1
        content.categoryIdentifier = Inscriptions.categoryIdentifierTimerNotification
        if let attachment = createUNNotificationAttachment() {
            content.attachments = [attachment]
        }
        return content
    }()

    private lazy var productContent: UNMutableNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = Inscriptions.titleOfAddedProductNotification
        content.body = Inscriptions.bodyOfAddedProductNotification
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "nom.wav"))
        return content
    }()
    
    // MARK: - Init
    
    override init() {
        super.init()
        notificationCenter.delegate = self
        requestAuthorization()
        cleanBadgesAtStarting()
    }

    // MARK: - Public methods

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                    @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case Inscriptions.identifierSnoozeOneMinuteButton:
            showTimerNotification(throughMinutes: 1)
        case Inscriptions.identifierSnoozeFiveMinuteButton:
            showTimerNotification(throughMinutes: 5)
        default:
            break
        }
        completionHandler()
    }

    // MARK: - Private methods

    private func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    private func createUNNotificationAttachment() -> UNNotificationAttachment? {
        if let path = Bundle.main.path(forResource: ImageTitles.timerNotificationContent.title,
                                       ofType: ImageTitles.timerNotificationContent.type) {
            do {
                return try UNNotificationAttachment(identifier: ImageTitles.timerNotificationContent.title,
                                                    url: URL(fileURLWithPath: path))
            } catch { }
        }
        return nil
    }

    private func createNotificationCategory() -> UNNotificationCategory {
        let snoozeOneMinuteAction = UNNotificationAction(identifier: Inscriptions.identifierSnoozeOneMinuteButton,
                                                         title: Inscriptions.titleSnoozeOneMinuteButton,
                                                         options: [])
        let snoozeFiveMinuteAction = UNNotificationAction(identifier: Inscriptions.identifierSnoozeFiveMinuteButton,
                                                          title: Inscriptions.titleSnoozeFiveMinuteButton,
                                                          options: [])
        let turnOffAction = UNNotificationAction(identifier: Inscriptions.identifierTurnOffTimerButton,
                                                 title: Inscriptions.titleTurnOffTimerButton,
                                                 options: [.destructive])
        let category = UNNotificationCategory(identifier: Inscriptions.categoryIdentifierTimerNotification,
                                              actions: [snoozeOneMinuteAction, snoozeFiveMinuteAction, turnOffAction],
                                              intentIdentifiers: [], options: [])
        return category
    }
    
    @objc private func applicationDidBecomeActive(notification: NSNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

// MARK: Extension

extension NotificationService: NotificationServiceProtocol {

    /// Вызывается для проверки настроек уведомлений у пользователя. Если уведомления выключены, вызывается замыкание.
    func checkNotificationSettings(completion: @escaping () -> Void) {
        notificationCenter.getNotificationSettings { settings in
            if settings.authorizationStatus == .denied ||
                settings.authorizationStatus == .notDetermined {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }

    /// Очищение бейджей при запуске приложения
    func cleanBadgesAtStarting() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    func showTimerNotification(throughMinutes: Double) {
        let numberOfSeconds = 60 * throughMinutes
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: numberOfSeconds, repeats: false)
        let identifier = Inscriptions.identifierOfTimerNotification
        let request = UNNotificationRequest(identifier: identifier, content: timerContent, trigger: trigger)
        let category = createNotificationCategory()
        notificationCenter.add(request)
        notificationCenter.setNotificationCategories([category])
    }

    func showProductWasAddedNotification() {
        let identifier = Inscriptions.identifierOfAddedProductNotification
        let request = UNNotificationRequest(identifier: identifier, content: productContent, trigger: nil)
        notificationCenter.add(request)
    }

    /// Отменить отложенное уведомление
    func cancelTimerNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }

    /// Если у пользователя отключены уведомления, появляется alert с предупреждением и ссылкой на настройки
    func notificationsAreNotAvailableAlert() -> UIAlertController {
        let alert = UIAlertController(title: Inscriptions.titleNotificationsAreNotAvailableAlert,
                                      message: Inscriptions.messageNotificationsAreNotAvailableAlert,
                                      preferredStyle: .actionSheet)

        let settingsAction = UIAlertAction(title: Inscriptions.okActionNotAvailableAlert,
                                           style: .destructive) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        let cancelAction = UIAlertAction(title: Inscriptions.cancelActionNAreNotAvailableAlert,
                                         style: .default)
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        return alert
    }
}
