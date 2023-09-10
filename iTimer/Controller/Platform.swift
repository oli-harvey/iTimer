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
        case .iOS: return 36
        case .watchOS: return 18
        default: return 36
        }
    }
    static var secondarytTextFontSize: CGFloat {
        switch current {
        case .iOS: return 30
        case .watchOS: return 14
        default: return 30
        }
    }
    static var buttonWidth: CGFloat {
        switch current {
        case .iOS: return 260
        case .watchOS: return 130
        default: return 260
        }
    }
    
    static var buttonHeight: CGFloat {
        switch current {
        case .iOS: return 100
        case .watchOS: return 50
        default: return 100
        }
    }
    
}
