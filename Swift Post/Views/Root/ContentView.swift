import Alamofire
import CodeEditor
import SwiftJSONFormatter
import SwiftUI

struct ContentView: View {
    @AppStorage("codeEditorTheme") private var codeEditorTheme: CodeEditor.ThemeName = .agate
    @StateObject private var manager = Manager()
    @State private var linkInput: String = ""
    @State private var requestMethod: HTTPMethod = .get
    @State private var responseData: String = ""
    @State private var paramInputs: [BasicInput] = [BasicInput()]
    @State private var headerInputs: [BasicInput] = [BasicInput()]
    @State private var bodyInputs: [BasicInput] = [BasicInput()]
    @State private var requestHeaders: [String] = []
    @State private var requestBody: String = ""
    @State private var bindingRawBodyJSON: String = "{}"
    @State private var uneditablePlaceHolder = ""
    @State private var extractedJSON: [String: String] = [:]
    @State private var invalidJSON = false
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Picker("Request Method", selection: $requestMethod) {
                    ForEach(HTTPMethod.allCases, id: \.self) { method in
                        Text(method.rawValue)
                    }
                }
                    .labelsHidden()
                    .pickerStyle(.automatic)
                    .frame(width: 75)
                TextField("Enter base URL here...", text: $linkInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    responseData = ""
                    manager.loading = true
                    manager.rawBody = bindingRawBodyJSON
                    manager.paramInputs = paramInputs
                    manager.headerInputs = headerInputs
                    manager.bodyInputs = bodyInputs
                    manager.linkInput = linkInput
                    manager.requestMethod = requestMethod.rawValue
                    manager.middleWareFunction()
                }) {
                    Text("Run (")
                    Image(systemName: "command")
                    Text("+ R )")
                }
                    .keyboardShortcut("R", modifiers: [.command])
                    .disabled(linkInput == "" || manager.loading)
            }
                .padding(.all)
            TabView {
                InputListView(inputs: $paramInputs, title: "Params", addButtonLabel: "+ Add Parameter") {
                    index in
                    ParamInputView(
                        paramInput: $paramInputs[index],
                        paramInputs: $paramInputs,
                        showMinusButton: index != 0
                    )
                        .padding()
                }

                InputListView(inputs: $headerInputs, title: "Headers", addButtonLabel: "+ Add Header") {
                    index in
                    HeaderInputView(
                        headerInput: $headerInputs[index],
                        headerInputs: $headerInputs,
                        showMinusButton: index != 0
                    )
                        .padding()
                }
                VStack {

                    HStack {
                        CodeEditor(source: $bindingRawBodyJSON, language: .json, theme: codeEditorTheme)
                            .onChange(of: bindingRawBodyJSON) { newValue in
                            bindingRawBodyJSON = bindingRawBodyJSON.replacingOccurrences(of: "“", with: "\"")
                            bindingRawBodyJSON = bindingRawBodyJSON.replacingOccurrences(of: "”", with: "\"")
                            bindingRawBodyJSON = bindingRawBodyJSON.replacingOccurrences(of: "‘", with: "'")
                            bindingRawBodyJSON = bindingRawBodyJSON.replacingOccurrences(of: "’", with: "'")
                            let isValidJSON = manager.checkValidJson(jsonString: bindingRawBodyJSON)
                            if isValidJSON {
                                invalidJSON = false
                                let keyValuePair = manager.extractKeyValuePairs(from: bindingRawBodyJSON)
                                if keyValuePair != [:] {
                                    extractedJSON = keyValuePair
                                }
                            } else {
                                invalidJSON = true
                            }
                        }
                        Group {
                            VStack {
                                if extractedJSON.count != 0 && !invalidJSON {
                                    List {
                                        Section(
                                            header:
                                                Text("Body Key-Value Pair")
                                                .font(.title3)
                                                .padding(.horizontal)
                                        ) {
                                            ForEach(Array(extractedJSON), id: \.key) { key, value in
                                                Cell(leading: "\(key)", trailing: "\(value)")
                                            }
                                        }
                                    }
                                }
                                if invalidJSON && extractedJSON.count != 0 {
                                    List {
                                        Section(
                                            header:
                                                Text("INVALID JSON")
                                                .font(.title2)
                                                .padding(.horizontal)
                                        ) {
                                            HStack {
                                                Spacer()
                                                VStack(alignment: .center) {
                                                    Image(systemName: "exclamationmark.triangle.fill")
                                                        .font(.largeTitle)
                                                    Text("The JSON you've entered is invalid.\nPlease recheck the syntax or any characters that might be missing.")
                                                }
                                                Spacer()
                                            }
                                                .multilineTextAlignment(.center)

                                        }
                                    }
                                }
                                if extractedJSON.count == 0 {
                                    List {
                                        Section(
                                            header:
                                                Text("Start Typing")
                                                .font(.title2)
                                                .padding(.horizontal)
                                        ) {
                                            HStack {
                                                Spacer()
                                                VStack(alignment: .center) {
                                                    Image(systemName: "keyboard")
                                                        .font(.largeTitle)
                                                        .padding(.vertical)
                                                    Text("Start typing the body as a valid JSON on the left and you'll see the translated body in a Key-Value pair here.")
                                                }
                                                Spacer()
                                            }
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                            }
                        }
                            .tabItem {
                            Label("BODY", systemImage: "list.dash")
                        }
                    }
                }
                    .tabItem {
                    Label("Body", systemImage: "list.dash")
                }
            }
            Section {
                ZStack(alignment: .top) {
                    CodeEditor(source: $responseData, language: .json, theme: codeEditorTheme, flags: [.selectable])
                        .padding(.bottom)
                        .padding(.horizontal)
                        .onReceive(manager.$responseData) { newValue in
                        responseData = newValue
                    }
                    if !responseData.isEmpty {
                        HStack(alignment: .top) {
                            Spacer()
                            Button(action: {
                                ClipboardManager().copyToClipboard(responseData)
                            }) {
                                Text("Copy")
                            }
                            Button(action: {
                                responseData = ""
                            }) {
                                Text("Clear")
                            }
                        }
                            .padding(.all)
                            .padding(.horizontal)
                    }
                    if manager.loading {
                        ProgressView()
                    }
                }
            }
                .alert("\(manager.errorAlertText)", isPresented: $manager.isErrorAlert) {
                Button("OK", role: .cancel) {
                    manager.loading = false
                    responseData = ""
                }
            }
        }
    }
}
