import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerConfigStorage: TimerConfigStorage
    @ObservedObject var timer: IntervalTimer
    var timerConfig: TimerConfig
    @State private var isIntervalCompleted = false
    
    @Environment(\.presentationMode) var presentationMode
    let dotSize: CGFloat = 8
    private let buttonSize = ScreenSize.deviceWidth * 0.2
    private let circleSize = ScreenSize.deviceWidth * 0.65

    var body: some View {
        ZStack {
            ProgressCircleView(timer: timer, isIntervalCompleted: $isIntervalCompleted)
                .frame(width: circleSize, height: circleSize)
            VStack {
                TimerNumericalView(timer: timer)
                IntervalDotsView(timer: timer, isIntervalCompleted: $isIntervalCompleted, dotSize: dotSize)
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        timer.stopTimer()
                        timer.resetTimer()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
//                    .padding(.top)
                    Spacer()
                    Button(action: {
                        if timer.isStopped {
                            timer.resetTimer()
                            timer.startTimer()
                        } else if timer.isPaused {
                            timer.resume()
                        } else {
                            timer.pause()
                        }
                    }) {
                        Image(systemName: timer.isStopped || timer.isPaused ? "play.circle" : "pause.circle")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                            .foregroundColor(.white)
 
                    }

                    .buttonStyle(.plain)
//                    .padding()

                }
            }
        }
        .padding()
    }
}

struct ProgressCircleView: View {
    @ObservedObject var timer: IntervalTimer
    @Binding var isIntervalCompleted: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 8)
                .scaleEffect(isIntervalCompleted ? 0.8 : 1.0)
                .animation(.easeInOut(duration:0.3), value: isIntervalCompleted)
//                .frame(width: 150, height: 150)

            Circle()
                .trim(from: 0.0, to: CGFloat(timer.progress))
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .scaleEffect(isIntervalCompleted ? 0.8 : 1.0)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration:0.3), value: isIntervalCompleted)
        }
    }
}

struct TimerNumericalView: View {
    @ObservedObject var timer: IntervalTimer

    var body: some View {
        VStack {
//            HStack {
                Text("\(timer.timeRemaining.humanReadable)")
                    .font(.system(size: Platform.textFontSize))
                    .bold()
                    .foregroundColor(.white)
//                Text("/ \(timer.intervalDuration.humanReadable)")
//                    .font(.system(size: Platform.textFontSize))
//                    .foregroundColor(.white)
//            }

            if timer.isCompleted {
                Text("Completed")
                    .font(.caption)
                    .foregroundColor(.white)
            }


            Text("Intervals: \(timer.intervalsElapsed) / \(timer.totalIntervals)")
                .foregroundColor(.white)
                .font(.system(size: Platform.secondarytTextFontSize))
        }
    }
}

//struct IntervalDotsView: View {
//    @ObservedObject var timer: IntervalTimer
//    @Binding var isIntervalCompleted: Bool
//    let dotSize: CGFloat
//
//    var body: some View {
//        LazyVGrid(columns: Array(repeating:GridItem(.fixed(dotSize)), count: min(10, timer.totalIntervals)), spacing: 10) {
//            ForEach(0..<timer.totalIntervals, id:\.self) { intervalIndex in
//                Circle()
//                    .fill(timer.intervalsElapsed > intervalIndex || isIntervalCompleted  ? Color.orange : Color.gray)
////                            .frame(width: 10, height: 10)
//                    .scaleEffect(isIntervalCompleted ? 1.2 : 1.0)
//                    .animation(.easeInOut(duration: 0.2), value: isIntervalCompleted)
//                    .onReceive(timer.$intervalsElapsed) { _ in
//                        // Trigger a flash animation when an interval is completed
//                        withAnimation(.easeInOut(duration: 0.2)) {
//                            isIntervalCompleted = true
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                isIntervalCompleted = false
//                            }
//                        }
//                    }
//            }
//        }
//    }
//}
struct IntervalDotsView: View {
    @ObservedObject var timer: IntervalTimer
    @Binding var isIntervalCompleted: Bool
    let dotSize: CGFloat

    // Constants
    let maxDotsPerRow = 6
    let dotSpacing: CGFloat = 4
    let maxDotsToShowText = 18

    var body: some View {
        let totalIntervals = timer.totalIntervals
        let numberOfRows = (totalIntervals + maxDotsPerRow - 1) / maxDotsPerRow

        let intervalsToDisplay = min(totalIntervals, maxDotsToShowText)
//        let extraDotsCount = totalIntervals - maxDotsToShowText

        VStack {
            if totalIntervals > maxDotsToShowText {
                HStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: dotSize, height: dotSize)
                    Text("\(timer.intervalsElapsed) / \(totalIntervals)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: dotSize + 10) // Adjust height as needed
            } else {
                ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                    HStack(spacing: dotSpacing) {
                        ForEach(0..<maxDotsPerRow, id: \.self) { columnIndex in
                            let dotIndex = rowIndex * maxDotsPerRow + columnIndex
                            if dotIndex < intervalsToDisplay {
                                Circle()
                                    .fill(timer.intervalsElapsed > dotIndex || isIntervalCompleted ? Color.orange : Color.gray)
                                    .frame(width: dotSize, height: dotSize)
                                    .scaleEffect(isIntervalCompleted ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.2), value: isIntervalCompleted)
                                    .onReceive(timer.$intervalsElapsed) { _ in
                                        // Trigger a flash animation when an interval is completed
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            isIntervalCompleted = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                isIntervalCompleted = false
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: totalIntervals > maxDotsToShowText ? dotSize + 10 : CGFloat(numberOfRows) * (dotSize + dotSpacing))
    }
}
