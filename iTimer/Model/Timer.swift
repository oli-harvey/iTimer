//import Foundation
//
//class ITimer:ObservableObject {
//    var timeInterval: TimeInterval
//    @Published var timer: Timer
//    
//    init(timeInterval: TimeInterval, invocation: Inv) {
//        self.timeInterval = timeInterval
//        self.timer = Timer(timeInterval:timeInterval, invocation:invocation, repeats: false)
//    }
//}

import SwiftUI

class IntervalTimer: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var intervalsElapsed: Int
    @Published var intervalsRemaining: Int
    @Published var totalIntervals: Int
    var isPaused = false
    var isStopped = true
    private var updateFreq = 0.01
    private var pausedDate: Date?
    
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
    
    private var timer: Timer?
    private let intervalDuration: TimeInterval

    
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
        timer = Timer.scheduledTimer(withTimeInterval: updateFreq, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            guard !isPaused else { return }
            if self.timeRemaining > updateFreq {
                self.timeRemaining -= updateFreq
            } else {
                self.intervalCompleted()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = intervalDuration
        intervalsElapsed = 0
        isStopped = true
    }
    
    private func intervalCompleted() {
        intervalsElapsed += 1
        intervalsRemaining -= 1
        
        if intervalsRemaining > 0 {
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
                startTimer()
                isPaused = false
            }
        }

    }
  
