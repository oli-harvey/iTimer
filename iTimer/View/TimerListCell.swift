import SwiftUI

struct TimerListCell: View {
        
    @State private var activateNavigationLink: Bool = false
    @State var timerConfig: TimerConfig
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
        
    var body: some View {
        NavigationLink(
            destination: TimerView(timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals)),
            isActive: $activateNavigationLink
        ) {
            Button(action: {
                activateNavigationLink = true
            }) {
                timerConfig.display
            }
            .frame(width: buttonWidth, height: buttonHeight)
            .timerStyle()
        }
    }
}

