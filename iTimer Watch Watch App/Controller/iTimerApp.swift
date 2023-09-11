
import SwiftUI
//import HealthKit

@main
struct iTimerApp: App {
    @StateObject private var timerConfigStorage = TimerConfigStorage()
    
    var body: some Scene {
        WindowGroup {
            TimerSelectorView()
                .environmentObject(timerConfigStorage)
        }
    }
}
