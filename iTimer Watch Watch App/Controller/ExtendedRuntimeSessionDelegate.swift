import WatchConnectivity
import WatchKit

class ExtendedRuntimeSessionDelegate: NSObject, WKExtendedRuntimeSessionDelegate {
    var session: WKExtendedRuntimeSession?
    
    // MARK: - WKExtendedRuntimeSessionDelegate
    
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        // Handle session invalidation
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Handle session start
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Handle session expiration
    }
    
    // MARK: - Session Control
    
    func startSession() {
        if session == nil {
            session = WKExtendedRuntimeSession()
            session?.delegate = self
            session?.start()
        }
    }
    
    func endSession() {
        if let existingSession = session {
            existingSession.invalidate()
            session = nil
        }
    }
}
