import SwiftUI
struct OnboardingView: View {
    @State private var currentIndex = 0
    @State private var total = 3
    @Binding var currentUserSignedIn: Bool
    var body: some View {
        Group {
            if currentIndex == 0 {
                withAnimation {
                    Page1(currentUserSignedIn: $currentUserSignedIn, index: $currentIndex)
                }
            }
            if currentIndex == 1 {
                withAnimation {
                    Page2(currentUserSignedIn: $currentUserSignedIn)
                }
            }
        }
            .frame(width: 500)
    }
}
