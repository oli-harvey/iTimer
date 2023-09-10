//
//  TimerCellDetail.swift
//  iTimer
//
//  Created by Oliver Harvey on 09/09/2023.
//

import SwiftUI

struct TimerCellDetail: View {
    @State var timerConfig: TimerConfig
    @ObservedObject var timer: IntervalTimer
    
    
//    func formatTime() -> String {
//        let hours = Int(timerConfig.intervalDuration) / 3600
//        let minutes = (Int(timerConfig.intervalDuration) % 3600) / 60
//        let seconds = Int(timerConfig.intervalDuration) % 60
//        var formattedTime = ""
//
//        if hours == 0 {
//            formattedTime = String(format: "%02d:%02d", minutes, seconds)
//        } else {
//            formattedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
//        }
//        return formattedTime
//    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: "timer.circle")
                    .foregroundColor(.orange)
                Image(systemName: "arrow.counterclockwise.circle")
                    .foregroundColor(.orange)
            }
            VStack(alignment: .leading) {
                if timer.isStopped {
                    Text(timerConfig.intervalDuration.humanReadable)
                        .font(.system(size: Platform.textFontSize))
                    Text("x\(timerConfig.totalIntervals)")
                        .font(.system(size: Platform.textFontSize))
                } else {
                    Text(timer.timeRemaining.humanReadable)
                        .font(.system(size: Platform.textFontSize))
                    Text("\(timer.intervalsElapsed) / \(timer.totalIntervals)")
                        .font(.system(size: Platform.textFontSize))
                }

            }
            Spacer()
        }
    }
}

