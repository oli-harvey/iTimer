import SwiftUI

class ScreenSize{
    #if os(watchOS)
    static var deviceWidth:CGFloat = WKInterfaceDevice.current().screenBounds.size.width
    #elseif os(iOS)
    static var deviceWidth:CGFloat = UIScreen.main.bounds.size.width
    #elseif os(macOS)
    static var deviceWidth:CGFloat? = NSScreen.main?.visibleFrame.size.width // You could implement this to force a CGFloat and get the full device screen size width regardless of the window size with .frame.size.width
    #endif
}
