import SwiftUI
struct ParamInputView: View {
    @Binding var paramInput: BasicInput
    @Binding var paramInputs: [BasicInput]
    var showMinusButton: Bool = true
    var body: some View {
        HStack {
            Image(systemName: paramInput.isChecked ? "checkmark.square" : "square")
                .onTapGesture {
                paramInput.isChecked.toggle()
            }
            TextField("Key", text: $paramInput.key)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Value", text: $paramInput.value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if showMinusButton {
                Button {
                    paramInputs.removeLast()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
}
