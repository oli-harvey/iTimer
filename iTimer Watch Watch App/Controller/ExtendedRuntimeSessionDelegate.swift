import WatchConnectivity
import WatchKit

import SwiftUI

class ExtendedRuntimeSessionDelegateProvider: ObservableObject {
    @Published var delegate = ExtendedRuntimeSessionDelegate()
}


class ExtendedRuntimeSessionDelegate: NSObject, WKExtendedRuntimeSessionDelegate {
    var session: WKExtendedRuntimeSession?
    
    // MARK: - WKExtendedRuntimeSessionDelegate
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        // Handle session invalidation
        print(reason)
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Handle session start
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Handle session expiration
        print(session)
        endSession()
    }
    
    // MARK: - Session Control
    
    func startSession() {
        print("Starting extended runtime session")
        endSession()
        session = WKExtendedRuntimeSession()
        session?.delegate = self
        session?.start()
    }
    
    func endSession() {
        if let existingSession = session {
            existingSession.invalidate()
            session = nil
        }
    }
}
