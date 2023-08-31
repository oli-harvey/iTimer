//
//  ContentView.swift
//  iTimer
//
//  Created by Oliver Harvey on 13/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timer = IntervalTimer(intervalDuration: 60.0, totalIntervals: 5)
        
                              
    
    var body: some View {
        VStack {
            Text("\(timer.timeRemainingFormatted)")
                .timerStyle()
            
            Text("Intervals: \(timer.intervalsElapsed / timer.intervalsRemaining)")
                .timerStyle()

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
