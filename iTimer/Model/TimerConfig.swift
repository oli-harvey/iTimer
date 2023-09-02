import SwiftUI

struct TimerConfig: Codable, Identifiable, Hashable {
    let intervalDuration: TimeInterval
    let totalIntervals: Int
    
    var id: String {
        "\(intervalDuration)-\(totalIntervals)"
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
