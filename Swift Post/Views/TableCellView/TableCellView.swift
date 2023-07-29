import SwiftUI
struct Cell: View {
    var leading: String
    var trailing: String
    var body: some View {
        HStack {
            Text(leading)
                .foregroundColor(.primary)
                .font(.title3)
                .padding(.horizontal)
            Text(" - ")
            Text(trailing).foregroundColor(.secondary)
                .font(.title3)
                .padding(.horizontal)
        }
    }

}
