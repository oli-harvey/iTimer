

import SwiftUI

class IntervalTimer: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var intervalsElapsed: Int
    @Published var intervalsRemaining: Int
    @Published var totalIntervals: Int
    @Published var isPaused = false
    @Published var isStopped = true
    private var updateFreq = 0.01
    private var timerStarted: Date? = nil
    private var pausedDate: Date?
    private var totalPausedTime: TimeInterval = 0
    
    private var timer: Timer?
    private let intervalDuration: TimeInterval
    
    var timeRemainingFormatted: String {
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var progress: Double {
        let timeElapsed = intervalDuration - timeRemaining
        return max(0.0, min(1.0, timeElapsed / intervalDuration))
    }

    
    init(intervalDuration: TimeInterval, totalIntervals: Int) {
        self.intervalDuration = intervalDuration
        self.totalIntervals = totalIntervals
        
        timeRemaining = intervalDuration
        intervalsElapsed = 0
        intervalsRemaining = totalIntervals
        
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    func startTimer() {
        isStopped = false
        if timerStarted == nil {
             timerStarted = Date() // Set the start time only if it's nil
         }
        
        timer = Timer.scheduledTimer(withTimeInterval: updateFreq, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                guard !self.isPaused else { return }
                if let started = self.timerStarted {
                    // Calculate elapsed time excluding paused periods
                    let currentTime = Date()
                    let elapsedTime = currentTime.timeIntervalSince(started) - self.totalPausedTime
                    let remainingTime = max(0, self.intervalDuration - elapsedTime)
                    self.timeRemaining = remainingTime
                    
                    if remainingTime <= 0 {
                        self.intervalCompleted()
                    }
                }
            }
    }

    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = intervalDuration
        intervalsElapsed = 0
        intervalsRemaining = totalIntervals
        isStopped = true
        timerStarted = nil
        totalPausedTime = 0
    }
    
    private func intervalCompleted() {
        intervalsElapsed += 1
        intervalsRemaining -= 1
    
        
        if intervalsRemaining > 0 {
            // Adjust the timerStarted by adding the time elapsed
            timerStarted = Date()
            totalPausedTime = 0
            timeRemaining = intervalDuration
        } else {
            stopTimer()
        }
    }
    func pause() {
            timer?.invalidate()
            pausedDate = Date() // Store the current date when paused
            isPaused = true
        }

    func resume() {
        if isPaused {
            if let paused = pausedDate {
                let currentTime = Date()
                let pausedTime = currentTime.timeIntervalSince(paused)
                totalPausedTime += pausedTime
            }
            isPaused = false
            
            startTimer()
        }
    }
}

