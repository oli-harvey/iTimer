import SwiftUI

struct AddTimerView: View {
    @Binding var isPresented: Bool // To control the popover
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var totalIntervals: Int = 0
    @State private var isSaveDisabled = true
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    
    enum FocusedField {
         case hours, minutes, seconds, interval
     }
    
    @FocusState private var focussedField: FocusedField?
    
    var body: some View {
        NavigationView {
            ScrollView {
//                Section(header: Text("Duration")) {
                Divider()
                    HStack {
                        HourPicker(hours: $hours)
                            .focused($focussedField, equals: .hours)
            //                            .contentShape(Rectangle())
                            .onTapGesture {focussedField = .hours}
                        VStack {
                            Text("")
                            Text(":")
                        }
                        MinutePicker(minutes: $minutes)
                            .focused($focussedField, equals: .minutes)
            //                            .contentShape(Rectangle())
                            .onTapGesture {focussedField = .minutes}
                        VStack {
                            Text("")
                            Text(":")
                        }
                        SecondPicker(seconds: $seconds)
                            .focused($focussedField, equals: .seconds)
            //                            .contentShape(Rectangle())
                            .onTapGesture {focussedField = .seconds}
                    }
                    .padding()
                    .padding()
                    .padding()
//                }
//                Section(header: Text("Intervals")) {
                Divider()
                Text("Total Intervals")
                    Picker("Total Intervals", selection: $totalIntervals) {
                        ForEach(1...100, id: \.self) { count in
                            Text("\(count)").tag(count)
                        }
//                    }
                }
                    .frame(maxWidth: 60, minHeight: 100)
//                    .border(Color("darkGrey"), width: 5)
//                    .cornerRadius(5)
                    .labelsHidden()
                    .pickerStyle(.wheel)
                    .focused($focussedField, equals: .interval)
                    .onTapGesture {focussedField = .interval}
                    .padding()
                Divider()
//                Section() {
                    VStack {
                        HStack {
                            Button("Cancel") {
                                isPresented = false
                            }
                            .padding()
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
                            .padding()
                        }
//                    }
                }
//                .onChange(of: hours) { _ in
//                    hoursFocusState = true
//                }
                .onChange(of: minutes) { _ in
                    focussedField = .minutes
                }
                .onChange(of: seconds) { _ in
                    focussedField = .seconds
                }
                .onChange(of: totalIntervals) { _ in
                    focussedField = .interval
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


struct HourPicker: View {
    @Binding var hours: Int
    
    var body: some View {
        VStack {
            Text("H")
            Picker("Hours", selection: $hours) {
                ForEach(0..<24, id: \.self) { hour in
                    Text("\(hour)").tag(hour)
                }
            }
            .frame(minHeight: 100)
//            .border(Color("darkGrey"), width: 5)
//            .cornerRadius(5)
            .pickerStyle(.wheel)
            .labelsHidden() // Hide the default label
            
        }

    }
}

struct MinutePicker: View {
    @Binding var minutes: Int
    
    var body: some View {
        VStack {
            Text("M")
            Picker("Minutes", selection: $minutes) {
                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute)").tag(minute)
                }
            }
            .frame(minHeight: 100)
//            .border(Color("darkGrey"), width: 5)
//            .cornerRadius(5)
            .pickerStyle(.wheel)
            .labelsHidden() // Hide the default label
        }

    }
}

struct SecondPicker: View {
    @Binding var seconds: Int
    
    var body: some View {
        VStack {
            Text("S")
            Picker("Seconds", selection: $seconds) {
                ForEach(0..<60, id: \.self) { second in
                    Text("\(second)").tag(second)
                }
            }
            .frame(minHeight: 100)
//            .border(Color("darkGrey"), width: 5)
//            .cornerRadius(5)
            .pickerStyle(.wheel)
            .labelsHidden() // Hide the default label
        }

    }
}



//struct DurationView: View {
//    @Binding var hours: Int
//    @Binding var minutes: Int
//    @Binding var seconds: Int
//
//    @FocusState private var hoursFocusState: Bool
//    @FocusState private var minutesFocusState: Bool
//    @FocusState private var secondsFocusState: Bool
//    @FocusState private var intervalFocusState: Bool
//
//
//    var body: some View {
//        HStack {
//            HourPicker(hours: $hours)
//                .focused($hoursFocusState)
////                            .contentShape(Rectangle())
//                .onTapGesture {hoursFocusState = true}
//            VStack {
//                Text("")
//                Text(":")
//            }
//            MinutePicker(minutes: $minutes)
//                .focused($minutesFocusState)
////                            .contentShape(Rectangle())
//                .onTapGesture {minutesFocusState = true}
//            VStack {
//                Text("")
//                Text(":")
//            }
//            SecondPicker(seconds: $seconds)
//                .focused($secondsFocusState)
////                            .contentShape(Rectangle())
//                .onTapGesture {secondsFocusState = true}
//        }
//    }
//}
