import SwiftUI
import CoreHaptics

class IOSHapticFeedbackGenerator {

  static func provideFeedback() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
  }

}
