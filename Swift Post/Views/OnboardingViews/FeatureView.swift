import SwiftUI

struct FeatureView: View {
    var imageName: String
    var title: String
    var desc: String
    var color: Color
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: imageName)
                .font(.system(size: 36))
                .frame(width: 60, height: 60)
                .background(color)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.title2)
                    .foregroundColor(.primary)
                Text(desc)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
                .padding(.vertical, 8)
        }
            .padding(.horizontal, 16)
    }
}
