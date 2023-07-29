import SwiftUI
struct Page1: View {
    @Binding var currentUserSignedIn: Bool
    @Binding var index: Int
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Welcome to Voyager")
                    .font(.system(size: 42))
                    .fontWeight(.bold)
                Text("A free to use API testing software for the macOS")
                    .font(.title2)
                    .fontWeight(.regular)
            }
            VStack(alignment: .leading) {
                FeatureView(imageName: "swift", title: "Native macOS App Built with Swift", desc: "Voyager is a developer-friendly and easy-to-use application designed for API testing, written in Swift for a seamless experience.", color: .orange)
                FeatureView(imageName: "slider.horizontal.3", title: "Customizable Requests", desc: "Tailor your API requests effortlessly with full control over parameters, headers, and request bodies, enabling precise interactions with APIs.", color: .gray)
                FeatureView(imageName: "bolt.circle", title: "Lightning-Fast Testing", desc: "Experience blazingly fast API testing with Voyager, ensuring rapid responses for quicker iterations and efficient development workflows.", color: .indigo)
            }
                .padding(.horizontal)
                .padding(.vertical, 40)
            Button(action: {
                index += 1
            }) {
                Text("Next")
                    .frame(maxWidth: 400)
                    .fontWeight(.bold)
            }
                .buttonStyle(CustomButtonStyle())
        }
            .padding(.vertical, 80)

    }
}
