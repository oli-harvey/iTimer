import SwiftUI

extension TimeInterval {

    var humanReadable: String {

        let seconds = Int(self)
        let minutes = seconds / 60
        let hours = minutes / 60

        if hours > 0 {
            return String(format: "%dh %dm", hours, minutes % 60)
        } else if minutes > 0 {
            return String(format: "%dm %ds", minutes, seconds % 60)
        } else {
            return String(format: "%ds", seconds)
        }
    }
}
