import SwiftUI

class TimerConfigStorage: ObservableObject {
    @StructArrayStorage(key: "timers", defaultValue: [TimerConfig(intervalDuration: 120, totalIntervals: 4)]) var timers: [TimerConfig]
    
    func addTimer(_ timerConfig: TimerConfig) {
        timers.append(timerConfig)
        self.objectWillChange.send()
    }
    
    
    
    // Add any other methods or properties related to timer management here
}

