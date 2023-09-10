import SwiftUI

struct TimerTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        if Platform.current == .watchOS {
            return AnyView( content
                .font(.system(size: Platform.textFontSize))
                .padding(.horizontal, 10)
                .padding(.vertical, 2)
                .foregroundColor(.white)
                .background(Color("darkGrey"))
                .clipShape(Capsule()))
    
        } else {
            return AnyView(content
                .font(.system(size: Platform.textFontSize))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(Color("darkGrey"))
                .clipShape(Capsule()))
        }
        }

}

extension View {
    func timerStyle() -> some View {
        modifier(TimerTextStyle())
        
    }
}
