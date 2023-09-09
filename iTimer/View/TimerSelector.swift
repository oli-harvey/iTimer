import SwiftUI

struct TimerSelectorView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var isAddTimerPopoverPresented: Bool = false
    
    private let buttonWidth = ScreenSize.deviceWidth * 0.7
    private let buttonHeight = ScreenSize.deviceWidth * 0.7 * 0.3
        
    var body: some View {
        NavigationView{
            VStack {
                Button(action: {isAddTimerPopoverPresented.toggle()}) {
                    HStack {
                        Image(systemName: "timer.circle")
                            .foregroundColor(.orange)
                        Text("New iTimer")
                            .font(.system(size: Platform.textFontSize))
                    }
                }
                .frame(width: buttonWidth, height: buttonHeight)
                .timerStyle()
                .sheet(isPresented: $isAddTimerPopoverPresented) {
                    AddTimerView(isPresented: $isAddTimerPopoverPresented)
                }
                ScrollView {
                    ForEach(timerConfigStorage.timers, id: \.id) { timerConfig in
                        TimerListCell(timerConfig: timerConfig, timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals), buttonWidth: buttonWidth, buttonHeight: buttonHeight)
                    }
                    
                }
                
            } 
            .padding()
//            .background(
//                NavigationLink("", destination: AddTimerView(isPresented: $isAddTimerPopoverPresented), isActive: $isAddTimerPopoverPresented)
//                    .opacity(0)
//            )
            .navigationTitle("Interval Timers")
        }
    }
}

//struct TimerSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerSelectorView()
//    }
//}
