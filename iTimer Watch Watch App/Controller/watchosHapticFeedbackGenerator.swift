import WatchConnectivity
import SwiftUI

class WatchOShapticfeedbackgenerator {

  static func provideFeedback() {
      WKInterfaceDevice.current().play(.success)
  }

}
