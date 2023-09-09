import SwiftUI

struct TimerSelectorView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var isAddTimerPopoverPresented: Bool = false
    
    private let buttonWidth = UIScreen.main.bounds.width * 0.7
    private let buttonHeight = UIScreen.main.bounds.width * 0.7 * 0.3
        
    var body: some View {
        NavigationView{
            VStack {
                Button(action: {isAddTimerPopoverPresented.toggle()}) {
                    HStack {
                        Image(systemName: "timer.circle")
                            .foregroundColor(.orange)
                        Text("New iTimer")
                    }
                }
                .frame(width: buttonWidth, height: buttonHeight)
                .timerStyle()
                .popover(isPresented: $isAddTimerPopoverPresented) {
                    AddTimerView(isPresented: $isAddTimerPopoverPresented)
                }
                ScrollView {
                    ForEach(timerConfigStorage.timers, id: \.id) { timerConfig in
                        TimerListCell(timerConfig: timerConfig, timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals), buttonWidth: buttonWidth, buttonHeight: buttonHeight)
                    }
                    
                }
                
            } 
            .padding()
            .background(
                NavigationLink("", destination: AddTimerView(isPresented: $isAddTimerPopoverPresented), isActive: $isAddTimerPopoverPresented)
                    .opacity(0)
            )
            .navigationTitle("Interval Timers")
        }
    }
}

//struct TimerSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerSelectorView()
//    }
//}
