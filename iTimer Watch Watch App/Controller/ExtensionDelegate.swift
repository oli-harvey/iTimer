import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

  func applicationDidFinishLaunching() {
    
      // Start timer
      Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
        // Refresh app
      }

      // Run a never ending loop
      while true { }
    
  }

}
