import SwiftUI
import CoreHaptics

class iOSHapticManager {

  static func provideFeedback() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
  }

}
