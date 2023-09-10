//import SwiftUI
//import CoreHaptics
//import WatchConnectivity
//
//class HapticFeedbackProvider {
//    static func provideHapticFeedback() {
//        switch Platform.current {
//        case .iOS:
//            provideiOSHapticFeedback()
//        case .watchOS:
//            provideWatchOSHapticFeedback()
//        default:
//            provideiOSHapticFeedback()
//        }
//    }
//
//    private static func provideiOSHapticFeedback() {
//        if #available(iOS 10.0, *) {
//            let feedbackGenerator = UINotificationFeedbackGenerator()
//            feedbackGenerator.notificationOccurred(.success)
//        }
//    }
//
//    private static func provideWatchOSHapticFeedback() {
//        WKInterfaceDevice.current().play(.success)
//    }
//}
