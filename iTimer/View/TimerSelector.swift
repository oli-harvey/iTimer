import SwiftUI

struct TimerSelectorView: View {
    @StructArrayStorage(key: "timers", defaultValue: [TimerConfig(intervalDuration: 120, totalIntervals: 4)]) var timers: [TimerConfig]
    @State private var selectedTimerConfig: TimerConfig?
        
    var body: some View {
        NavigationView{
            VStack {
                Text("Select a timer matey")
                Button("New Timer") {
                    print("new tapped")
                }
                .timerStyle()
                List(timers, id: \.id) { timer in
                    NavigationLink(
                        destination: TimerView(timer: IntervalTimer(intervalDuration: timer.intervalDuration, totalIntervals: timer.totalIntervals)),
                        tag: timer,
                        selection: $selectedTimerConfig
                    ) {
                        Text("\(timer.intervalDuration)")
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onTapGesture {
                        selectedTimerConfig = timer
                    }
                }
                
            }
            .padding()
        }
    }
}

struct TimerSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectorView()
    }
}
