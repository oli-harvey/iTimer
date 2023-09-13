import SwiftUI

extension TimeInterval {

    var humanReadable: String {

        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
//        let milliseconds = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        var formattedTime = ""
        
        if hours == 0 {
            formattedTime = String(format: "%02d:%02d", minutes, seconds)
        } else {
            formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        
        return formattedTime
    }
}
