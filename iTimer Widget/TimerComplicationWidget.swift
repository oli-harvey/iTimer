import WidgetKit
import SwiftUI

struct TimerComplication: Widget {
    let kind: String = "TimerComplication"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TimerComplicationView()
        }
        .configurationDisplayName("Timer Complication")
        .description("This is a timer complication.")
        .supportedFamilies([.systemSmall])  // You can add more families if you need
    }
}

