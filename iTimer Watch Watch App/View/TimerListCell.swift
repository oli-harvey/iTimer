import SwiftUI

struct TimerListCell: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var activateNavigationLink: Bool = false
    @State var timerConfig: TimerConfig
    @ObservedObject var timer: IntervalTimer
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
            destination: TimerView(timer: timer, timerConfig: timerConfig),
            isActive: $activateNavigationLink
        ) {
            Button(action: {
                activateNavigationLink = true
            }) {
                TimerCellDetail(timerConfig: timerConfig, timer: timer)
            }
            .buttonStyle(.plain)

            .frame(width: buttonWidth, height: buttonHeight)
            .timerStyle()
            .gesture(longPressGesture)
            .background(.clear)

        }
    }
}

