
import SwiftUI
import WatchKit

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
