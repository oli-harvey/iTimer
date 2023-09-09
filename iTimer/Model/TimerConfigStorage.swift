import SwiftUI

class TimerConfigStorage: ObservableObject {
    @StructArrayStorage(key: "timers", defaultValue: [TimerConfig(intervalDuration: 120, totalIntervals: 4)]) var timers: [TimerConfig]
//    @Published var timerDictionary: [TimerConfig: IntervalTimer] = [:]
    
    func addTimer(_ timerConfig: TimerConfig) {
        timers.append(timerConfig)
        self.objectWillChange.send()
    }
    
    func removeTimer(_ timerConfig: TimerConfig) {
        timers.removeAll { $0.id == timerConfig.id }
        self.objectWillChange.send()
    }

}

