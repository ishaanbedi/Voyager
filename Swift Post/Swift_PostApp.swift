import SwiftUI
import CodeEditor
@main
struct Swift_PostApp: App {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @State private var themes: [CodeEditor.ThemeName] = [.agate, .atelierSavannaDark, .ocean, .pojoaque]
    @AppStorage("codeEditorTheme") private var codeEditorTheme: CodeEditor.ThemeName = .agate
    var body: some Scene {
        WindowGroup {
            Group {
                if !currentUserSignedIn {
                    OnboardingView(currentUserSignedIn: $currentUserSignedIn)
                        .frame(width: 750, height: 750)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ContentView()
                        .frame(minWidth: 1200, minHeight: 750)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
            .commands {
            CommandMenu("Report An Issue") {
                Link("Open an issue on GitHub", destination: URL(string: "https://github.com/ishaanbedi/swift-post-temp/issues")!)
                Link("Get support on Email", destination: URL(string: "mailto:hi@ishaanbedi.in?subject=Issue_With_Voyager")!)
            }
            CommandMenu("Settings") {
                Menu {
                    ForEach(themes, id: \.self) { item in
                        Button("\(item.rawValue) \(item.rawValue == codeEditorTheme.rawValue ? "•" : "")") {
                            codeEditorTheme = item
                        }
                    }
                } label: {
                    Text("Change Editor Theme")
                }
                Button("Reset App") {
                    currentUserSignedIn.toggle()
                    UserDefaults.resetStandardUserDefaults()
                }
            }
        }
    }
}
