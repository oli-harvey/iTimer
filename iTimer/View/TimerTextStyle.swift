import SwiftUI

struct TimerTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(Color.black.opacity(0.75))
            .clipShape(Capsule())
    }
}

extension View {
    func timerStyle() -> some View {
        modifier(TimerTextStyle())
    }
}
