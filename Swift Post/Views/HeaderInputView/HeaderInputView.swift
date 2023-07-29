import SwiftUI
struct HeaderInputView: View {
    @Binding var headerInput: BasicInput
    @Binding var headerInputs: [BasicInput]
    var showMinusButton: Bool = true
    var body: some View {
        HStack {
            Image(systemName: headerInput.isChecked ? "checkmark.square" : "square")
                .onTapGesture {
                    headerInput.isChecked.toggle()
                }
            TextField("Key", text: $headerInput.key)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Value", text: $headerInput.value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if showMinusButton {
                Button {
                    headerInputs.removeLast()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
