import SwiftUI
struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(configuration.isPressed ? .blue.opacity(0.8) : .blue)
        )
    }
}
