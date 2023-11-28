import SwiftUI
struct Page2: View {
    let githubURL = "https://github.com/ishaanbedi/Voyager"
    let contactURL = "mailto:hi@ishaanbedi.in"
    let documentationURL = "https://www.ishaanbedi.in/posts/voyager"
    @Binding var currentUserSignedIn: Bool
    var body: some View {
        VStack(spacing: 20) {
            Text("About Voyager")
                .font(.system(size: 42))
                .fontWeight(.bold)
            Text("Voyager is an open-sourced application.")
                .font(.system(size: 20))
            HStack {
                Link("Source Code", destination: URL(string: githubURL)!)
                Text(" | ")
                Link("Support", destination: URL(string: contactURL)!)
                Text(" | ")
                Link("Learn More", destination: URL(string: documentationURL)!)
            }
                .font(.system(size: 16))
            VStack {
                Text("Voyager does not collect any data from your system.\n\nIf you encounter any issues or have suggestions for improvements, feel free to open an issue on GitHub or email the developer at hi@ishaanbedi.in")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            Button(action: {
                currentUserSignedIn.toggle()
            }) {
                Text("Get Started")
                    .frame(maxWidth: 400)
                    .fontWeight(.bold)
            }
                .buttonStyle(CustomButtonStyle())
                .padding(.top, 55)
        }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
