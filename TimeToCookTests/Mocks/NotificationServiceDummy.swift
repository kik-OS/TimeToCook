//
//  File.swift
//  TimeToCookTests
//
//  Created by Никита Гвоздиков on 29.08.2021.
//

import UIKit

final class NotificationServiceDummy: NotificationServiceProtocol {
    
    func checkNotificationSettings(completion: @escaping () -> Void) { }
    func cleanBadgesAtStarting() { }
    func showTimerNotification(throughMinutes: Double) { }
    func showProductWasAddedNotification() { }
    func cancelTimerNotification() { }
    func notificationsAreNotAvailableAlert() -> UIAlertController { UIAlertController() }
}
