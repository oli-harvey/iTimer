//
//  ContentView.swift
//  iTimer
//
//  Created by Oliver Harvey on 13/08/2023.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: IntervalTimer
    
    var body: some View {
        VStack {
            Text("\(timer.timeRemainingFormatted)")
                .timerStyle()
            
            Text("Intervals: \(timer.intervalsElapsed) / \(timer.totalIntervals)")
                .timerStyle()

        }
        .padding()
    }
}

//struct TimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerView(timerConfig: TimerConfig(intervalDuration: 3, totalIntervals: 2))
//    }
//}
