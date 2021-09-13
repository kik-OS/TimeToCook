//
//  TimerViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation

// MARK: - Protocol

protocol TimerViewModelProtocol: AnyObject {
    var minutes: Int { get }
    var timerTime: (totalSeconds: Int, remainingSeconds: Int) { get }
    var isHiddenPickerStackView: Bool { get }
    var isHiddenDiagramStackView: Bool { get }
    var isEnabledStartButton: Bool { get }
    var isHiddenStartButton: Bool { get }
    var isHiddenStopButton: Bool { get }
    var setupPickerView: (() -> Void)? { get set }
    /// Вызывается при каждом шаге таймера.
    var timerDidStep: ((_ totalSeconds: Int, _ remainingSeconds: Int) -> Void)? { get set }
    /// Вызывается при остановке таймера пользователем.
    var timerDidStop: (() -> Void)? { get set }
    /// Вызывается при истечении времени таймера.
    var timerDidExpired: (() -> Void)? { get set }
    
    init(timerService: TimerServiceProtocol,
         notificationService: NotificationServiceProtocol,
         minutes: Int)
    
    func updateTimeTo(minutes: Int)
    func startTimer()
    func stopTimer()
}

// MARK: - Class

final class TimerViewModel: TimerViewModelProtocol {

    // MARK: - Services
    
    private var timerService: TimerServiceProtocol
    private var notificationService: NotificationServiceProtocol

    // MARK: - Properties
    
    var minutes: Int
    
    var timerTime: (totalSeconds: Int, remainingSeconds: Int) {
        timerService.getTimerTime()
    }
    
    var isHiddenPickerStackView: Bool {
        timerService.isActive
    }
    
    var isHiddenDiagramStackView: Bool {
        !timerService.isActive
    }
    
    var isEnabledStartButton: Bool {
        !timerService.isActive && minutes != 0
    }
    
    var isHiddenStartButton: Bool {
        timerService.isActive
    }
    
    var isHiddenStopButton: Bool {
        !timerService.isActive
    }
    
    var setupPickerView: (() -> Void)?
    var timerDidStep: ((_ totalSeconds: Int, _ remainingSeconds: Int) -> Void)?
    var timerDidStop: (() -> Void)?
    var timerDidExpired: (() -> Void)?

    // MARK: - Init
    
    init(timerService: TimerServiceProtocol,
         notificationService: NotificationServiceProtocol,
         minutes: Int = 0) {
        self.minutes = minutes
        self.timerService = timerService
        self.notificationService = notificationService
        self.timerService.timerViewDelegate = self
    }
    
    // MARK: - Public methods
    
    func updateTimeTo(minutes: Int) {
        self.minutes = minutes
    }
        
    func startTimer() {
        timerService.start(forMinutes: minutes)
        notificationService.showTimerNotification(throughMinutes: Double(minutes))
    }
    
    func stopTimer() {
        timerService.stop()
        notificationService.cancelTimerNotification()
    }
}

// MARK: - Extensions

extension TimerViewModel: TimerServiceTimerViewDelegate {
    
    func timerDidStep(totalSeconds: Int, remainingSeconds: Int, isStopped: Bool) {
        isStopped
            ? timerDidStop?()
            : timerDidStep?(totalSeconds, remainingSeconds)
    }
    
    func timerHasExpired() {
        timerDidExpired?()
    }
}
