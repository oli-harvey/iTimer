import SwiftUI

struct AddTimerView: View {
    @Binding var isPresented: Bool // To control the popover
    @State private var intervalDuration: TimeInterval = 0
    @State private var totalIntervals: Int = 0
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Timer Details")) {
                    TextField("Interval Duration (seconds)", value: $intervalDuration, formatter: NumberFormatter())
                    TextField("Total Intervals", value: $totalIntervals, formatter: NumberFormatter())
                }
            }
            .navigationBarTitle("Add Timer")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    // Validate input and add the new TimerConfig to the array
                    let newTimerConfig = TimerConfig(intervalDuration: intervalDuration, totalIntervals: totalIntervals)
                    timerConfigStorage.addTimer(newTimerConfig)
                    isPresented = false
                }
            )
        }
    }
}

