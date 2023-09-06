import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: IntervalTimer
    @State private var isIntervalCompleted = false
    @Environment(\.presentationMode) var presentationMode
    let dotSize: CGFloat = 10
    private let buttonSize = UIScreen.main.bounds.width * 0.1

    var body: some View {
        ZStack {
            ProgressCircleView(timer: timer, isIntervalCompleted: $isIntervalCompleted)
            VStack {
                TimerNumericalView(timer: timer)
                IntervalDotsView(timer: timer, isIntervalCompleted: $isIntervalCompleted, dotSize: dotSize)
            }
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        timer.stopTimer()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: buttonSize, height: buttonSize)
                    }
                    Spacer()
                    Button(action: {
                        timer.isPaused ? timer.resume() : timer.pause()
                    }) {
                        if timer.isPaused {
                            Image(systemName: "play.circle")
                                .resizable()
                                .frame(width: buttonSize, height: buttonSize)
                        } else {
                            Image(systemName: "pause.circle")
                                .resizable()
                                .frame(width: buttonSize, height: buttonSize)
                        }
 
                    }
                    .padding()

                }
            }
            .onAppear() {
                if timer.isStopped {timer.startTimer()}
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
                .stroke(Color.gray, lineWidth: 10)
                .scaleEffect(isIntervalCompleted ? 0.8 : 1.0)
                .animation(.easeInOut(duration:0.3), value: isIntervalCompleted)
//                .frame(width: 150, height: 150)

            Circle()
                .trim(from: 0.0, to: CGFloat(timer.progress))
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
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
            Text("\(timer.timeRemainingFormatted)")
                .font(.title)
                .bold()
                .foregroundColor(.white)

            Text("Intervals: \(timer.intervalsElapsed) / \(timer.totalIntervals)")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

struct IntervalDotsView: View {
    @ObservedObject var timer: IntervalTimer
    @Binding var isIntervalCompleted: Bool
    let dotSize: CGFloat

    var body: some View {
        LazyVGrid(columns: Array(repeating:GridItem(.fixed(dotSize)), count: min(10, timer.totalIntervals)), spacing: 10) {
            ForEach(0..<timer.totalIntervals, id:\.self) { intervalIndex in
                Circle()
                    .fill(timer.intervalsElapsed > intervalIndex || isIntervalCompleted  ? Color.orange : Color.gray)
//                            .frame(width: 10, height: 10)
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

