import SwiftUI
struct InputListView<Content: View>: View {
    @Binding var inputs: [BasicInput]
    let title: String
    let addButtonLabel: String

    let content: (Int) -> Content
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(inputs.indices, id: \.self) { index in
                    content(index)
                }

                Button(action: {
                    inputs.append(BasicInput())
                }) {
                    Text(addButtonLabel)
                }
                    .padding()
            }

        }
            .tabItem {
            Label(title, systemImage: "list.dash")
        }
    }
}
