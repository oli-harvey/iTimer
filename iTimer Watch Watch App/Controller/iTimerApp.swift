
import SwiftUI
import WatchKit

@main
struct iTimerApp: App {
    @StateObject private var timerConfigStorage = TimerConfigStorage()
//    @StateObject private var extendedSessionProvider = ExtendedRuntimeSessionDelegateProvider()
    
    var body: some Scene {
        WindowGroup {
            TimerSelectorView()
                .environmentObject(timerConfigStorage)
//                .environmentObject(extendedSessionProvider)
        }
    }
    
    
}
