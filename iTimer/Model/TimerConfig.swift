import SwiftUI

struct TimerConfig: Codable, Identifiable, Hashable {
    let intervalDuration: TimeInterval
    let totalIntervals: Int
    var id = UUID()
    
//    var id: String {
//        "\(intervalDuration)-\(totalIntervals)"
//    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var display: some View {
        let hours = Int(intervalDuration) / 3600
        let minutes = (Int(intervalDuration) % 3600) / 60
        let seconds = Int(intervalDuration) % 60
        var formattedTime = ""
        
        if hours == 0 {
            formattedTime = String(format: "%02d:%02d", minutes, seconds)
        } else {
            formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
            
        return HStack {
            VStack {
                Image(systemName: "timer.circle")
                Image(systemName: "arrow.counterclockwise.circle")
            }
            VStack(alignment: .leading) {
                Text(formattedTime)
                Text("x\(totalIntervals)")
            }
        }
    }

}
