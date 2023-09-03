import SwiftUI

struct TimerSelectorView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var selectedTimerConfig: TimerConfig?
    @State private var isAddTimerPopoverPresented: Bool = false
    @State private var isTimerViewPresented = false
        
    var body: some View {
        NavigationView{
            VStack {
                Button("New Timer") {
                    isAddTimerPopoverPresented.toggle()
                }
                .timerStyle()
                .popover(isPresented: $isAddTimerPopoverPresented) {
                    AddTimerView(isPresented: $isAddTimerPopoverPresented)
                }
                ScrollView {
                    ForEach(timerConfigStorage.timers, id: \.id) { timerConfig in
                        Button(action: {
                            selectedTimerConfig = timerConfig
                            isTimerViewPresented = true // Show the TimerView
                        }) {
                            Text(timerConfig.display)
                        }
                        .timerStyle()
                    }
                }
                
            } 
            .padding()
            .background(
                NavigationLink("", destination: AddTimerView(isPresented: $isAddTimerPopoverPresented), isActive: $isAddTimerPopoverPresented)
                    .opacity(0)
            )
            .navigationTitle("Interval Timers")
            .sheet(item: $selectedTimerConfig) { timerConfig in
                NavigationView {
                    TimerView(timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals))
                }
            }
        }
    }
}

struct TimerSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectorView()
    }
}
