import SwiftUI

struct AddTimerView: View {
    @Binding var isPresented: Bool // To control the popover
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var totalIntervals: Int = 0
    @State private var isSaveDisabled = true
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Duration")) {
                    HStack {
                        VStack {
                            Text("Hours")
                                .font(.system(size: Platform.textFontSize))
                            Picker("", selection: $hours) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text("\(hour)").tag(hour)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .labelsHidden() // Hide the default label
                        VStack {
                            Text("Minutes")
                                .font(.system(size: Platform.textFontSize))
                            Picker("", selection: $minutes) {
                                ForEach(0..<60, id: \.self) { minute in
                                    Text("\(minute)").tag(minute)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .labelsHidden() // Hide the default label
                        VStack {
                            Text("Seconds")
                                .font(.system(size: Platform.textFontSize))
                            Picker("", selection: $seconds) {
                                ForEach(0..<60, id: \.self) { second in
                                    Text("\(second)").tag(second)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .labelsHidden() // Hide the default label
                    }
                }
                Section(header: Text("Intervals")) {
                    Picker("Total Intervals", selection: $totalIntervals) {
                        ForEach(1...100, id: \.self) { count in
                            Text("\(count)").tag(count)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Section() {
                    VStack {
                        HStack {
                            Button("Cancel") {
                                isPresented = false
                            }
                            Spacer()
                            Button("Save") {
                                // Calculate the total interval duration in seconds
                                let intervalDuration = TimeInterval(hours * 3600 + minutes * 60 + seconds)
                                
                                // Validate input and add the new TimerConfig to the array
                                let newTimerConfig = TimerConfig(intervalDuration: intervalDuration, totalIntervals: totalIntervals)
                                timerConfigStorage.addTimer(newTimerConfig)
                                isPresented = false
                            }
                            .disabled(isSaveDisabled)
                        }
                    }
                }
                .onChange(of: [hours, minutes, seconds]) { newValues in

                  if newValues[0] == 0 &&
                      newValues[1] == 0 &&
                      newValues[2] == 0 {
                      
                    isSaveDisabled = true
                    
                  } else {
                  
                    isSaveDisabled = false
                  
                  }

                }
            }
            .navigationBarTitle("Add Timer")

        }
    }
}
