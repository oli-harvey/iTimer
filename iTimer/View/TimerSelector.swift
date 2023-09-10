import SwiftUI

struct TimerSelectorView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @State private var isAddTimerPopoverPresented: Bool = false
    
//    private let buttonWidth = ScreenSize.deviceWidth * 0.8
//    private let buttonHeight = ScreenSize.deviceWidth * 0.8 * 0.3
        
//    private let buttonWidth = 130.0
//    private let buttonHeight = 50.0
    
    var body: some View {
        NavigationView{
            List {
                Button(action: {isAddTimerPopoverPresented.toggle()}) {
                    HStack {
                        Image(systemName: "timer.circle")
                            .foregroundColor(.orange)
                        Text("New iTimer")
                            .font(.system(size: Platform.textFontSize))
                    }
                }
                .listRowBackground(Color.clear)
                .buttonStyle(.plain)
                .frame(width: Platform.buttonWidth, height: Platform.buttonHeight)
                .timerStyle()
                .sheet(isPresented: $isAddTimerPopoverPresented) {
                    AddTimerView(isPresented: $isAddTimerPopoverPresented)
                }
                ForEach(timerConfigStorage.timers, id: \.id) { timerConfig in
                    HStack(alignment: .center) {
//                        Spacer()
                        TimerListCell(timerConfig: timerConfig, timer: IntervalTimer(intervalDuration: timerConfig.intervalDuration, totalIntervals: timerConfig.totalIntervals), buttonWidth: Platform.buttonWidth, buttonHeight: Platform.buttonHeight)
                            .buttonStyle(.plain)
                            .background(Color.clear)
//                        Spacer()
                    }
  
                }
                .onDelete(perform: deleteTimer)
                .buttonStyle(.plain)
                .listRowBackground(Color.clear)
            }
            .listRowInsets(.none)
            .listRowBackground(Color.clear)
            .padding()
            .navigationTitle("Interval Timers")
        }
    }
    func deleteTimer(at offsets: IndexSet) {
        timerConfigStorage.timers.remove(atOffsets: offsets)
    }
}

