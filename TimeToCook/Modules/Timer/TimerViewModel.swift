//
//  TimerViewModel.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 11.08.2021.
//

import Foundation

// MARK: - Protocols

protocol TimerViewModelProtocol {
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
    
    init(timerService: TimerServiceProtocol, minutes: Int)
    
    func updateTimeTo(minutes: Int)
    func startTimer()
    func stopTimer()
}

final class TimerViewModel: TimerViewModelProtocol {
    
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
    
    private var timerService: TimerServiceProtocol
        
    // MARK: - Init
    
    init(timerService: TimerServiceProtocol, minutes: Int = 0) {
        self.minutes = minutes
        self.timerService = timerService
        self.timerService.timerViewDelegate = self
    }
    
    // MARK: - Public methods
    
    func updateTimeTo(minutes: Int) {
        self.minutes = minutes
    }
        
    func startTimer() {
        timerService.start(forMinutes: minutes)
        Notifications.shared.showTimerNotification(throughMinutes: Double(minutes))
    }
    
    func stopTimer() {
        timerService.stop()
        Notifications.shared.cancelTimerNotification()
    }
}

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
