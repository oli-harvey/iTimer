import SwiftUI

struct TimerListCell: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var activateNavigationLink: Bool = false
    @State var timerConfig: TimerConfig
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 1.0)
            .onEnded { _ in
                timerConfigStorage.removeTimer(timerConfig)
            }
    }
        
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
            .gesture(longPressGesture)
            .contextMenu {
                Button(action: {
                    timerConfigStorage.removeTimer(timerConfig)
                }) {
                    Text("Remove")
                }
            }
    
        }
    }
}

