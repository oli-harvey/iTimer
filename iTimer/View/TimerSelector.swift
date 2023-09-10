import SwiftUI

struct TimerSelectorView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var isAddTimerPopoverPresented: Bool = false
    
    private let buttonWidth = ScreenSize.deviceWidth * 0.8
    private let buttonHeight = ScreenSize.deviceWidth * 0.8 * 0.3
        
    var body: some View {
        NavigationView{
            ScrollView {
                Button(action: {isAddTimerPopoverPresented.toggle()}) {
                    HStack {
                        Image(systemName: "timer.circle")
                            .foregroundColor(.orange)
                        Text("New iTimer")
                            .font(.system(size: Platform.textFontSize))
                    }
                }
                .buttonStyle(.plain)
                .frame(width: buttonWidth, height: buttonHeight)
                .timerStyle()
                .sheet(isPresented: $isAddTimerPopoverPresented) {
                    AddTimerView(isPresented: $isAddTimerPopoverPresented)
                }
                ForEach(timerConfigStorage.timers, id: \.id) { timerConfig in
                    TimerListCell(timerConfig: timerConfig, timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals), buttonWidth: buttonWidth, buttonHeight: buttonHeight)
                        .buttonStyle(.plain)
                        .background(Color.clear)
                }
            } 
            .padding()
            .navigationTitle("Interval Timers")
        }
    }
}

