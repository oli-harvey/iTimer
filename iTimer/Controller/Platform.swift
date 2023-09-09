import Foundation

enum Platform {
    case iOS
    case watchOS
    case macOS
    case simulator
    
    static var current: Platform {
        #if os(iOS)
        return .iOS
        #elseif os(watchOS)
        return .watchOS
        #elseif os(macOS)
        return .macOS
        #else
        return .simulator
        #endif
    }
}


extension Platform {
    static var textFontSize: CGFloat {
        switch current {
        case .iOS: return 20
        case .watchOS: return 10
        default: return 20
        }
    }
}
