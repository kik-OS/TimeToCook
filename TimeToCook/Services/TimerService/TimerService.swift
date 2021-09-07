//
//  TimerManager.swift
//  TimeToCook
//
//  Created by Никита Гвоздиков on 29.08.2021.
//

import UIKit

// MARK: - Protocols

protocol TimerServiceBarDelegate: AnyObject {
    func timerDidStep(remainingSeconds: Int, isStopped: Bool)
}

protocol TimerServiceTimerViewDelegate: AnyObject {
    func timerDidStep(totalSeconds: Int, remainingSeconds: Int, isStopped: Bool)
    func timerHasExpired()
}

protocol TimerServiceProtocol: AnyObject {
    var isActive: Bool { get }
    var barDelegate: TimerServiceBarDelegate? { get set }
    var timerViewDelegate: TimerServiceTimerViewDelegate? { get set }
    
    func start(forMinutes minutes: Int)
    func stop()
    func getTimerTime() -> (totalSeconds: Int, remainingSeconds: Int)
    func saveTime()
    func readSavedTime()
}

final class TimerService: TimerServiceProtocol {

    // MARK: - Properties
    
    var isActive = false
    weak var barDelegate: TimerServiceBarDelegate?
    weak var timerViewDelegate: TimerServiceTimerViewDelegate?
    
    private var savedTime: (timerTime: Int, time: Double)?
    private var timer: Timer?
    /// Общее время таймера в секундах.
    private var totalTime = 0
    /// Текущее время таймера в секундах.
    private var timerTime = 0

    // MARK: - Public methods
    
    func start(forMinutes minutes: Int) {
        timer = Timer()
        totalTime = minutes * 60
        timerTime = totalTime
        let newTimer = Timer.scheduledTimer(timeInterval: 1,
                                            target: self,
                                            selector: #selector(stepTimer),
                                            userInfo: nil,
                                            repeats: true)
        newTimer.tolerance = 0.1
        /// Необходимо чтобы избавиться от лагов в UI при работающем таймере
        RunLoop.current.add(newTimer, forMode: .common)
        timer = newTimer
        isActive = true
    }
    
    func stop() {
        isActive = false
        timer?.invalidate()
        timer = nil
        updateTimers(remainingTime: timerTime, isStopped: true)
    }
    
    func getTimerTime() -> (totalSeconds: Int, remainingSeconds: Int) {
        (totalTime, timerTime)
    }
    
    func saveTime() {
        savedTime = isActive
            ? (timerTime: timerTime, time: CFAbsoluteTimeGetCurrent())
            : nil
    }
    
    func readSavedTime() {
        guard let savedTime = savedTime else { return }
        
        let elapsedTimeByTimer = savedTime.timerTime - timerTime
        let elapsedTimeAccurately = CFAbsoluteTimeGetCurrent() - savedTime.time
        
        let isOverTime = elapsedTimeAccurately > Double(savedTime.timerTime) && isActive
        if isOverTime {
            isActive = false
            updateTimers(remainingTime: 0, isStopped: false)
            timerViewDelegate?.timerHasExpired()
        } else if isActive {
            let delta = Int(elapsedTimeAccurately.rounded()) - elapsedTimeByTimer
            if delta > 1 {
                timerTime -= delta
            }
        }
    }
    
    // MARK: - Private methods
    
    @objc private func stepTimer(sender: Timer) {
        guard isActive, timerTime >= 0 else {
            isActive = false
            sender.invalidate()
            return
        }
        
        updateTimers(remainingTime: timerTime, isStopped: false)
        if timerTime == 0 {
            timerViewDelegate?.timerHasExpired()
        }
        timerTime -= 1
    }
    
    private func updateTimers(remainingTime: Int, isStopped: Bool) {
        barDelegate?.timerDidStep(remainingSeconds: remainingTime, isStopped: isStopped)
        timerViewDelegate?.timerDidStep(totalSeconds: totalTime,
                                        remainingSeconds: remainingTime,
                                        isStopped: isStopped)
    }
}
