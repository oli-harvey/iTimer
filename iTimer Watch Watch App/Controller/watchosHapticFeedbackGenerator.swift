import WatchConnectivity
import SwiftUI

class watchOSHapticManager {

  static func provideFeedback() {
    WKInterfaceDevice.current().play(.success)
  }

}
