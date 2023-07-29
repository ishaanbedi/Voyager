import Foundation
import Alamofire
import SwiftJSONFormatter

class Manager: ObservableObject {
    static let shared = Manager()
    @Published var responseData: String = ""
    @Published var isErrorAlert: Bool = false
    @Published var errorAlertText: String = ""
    var linkInput: String = ""
    var paramInputs: [BasicInput] = []
    var requestMethod: String = "GET"
    var bodyInputs: [BasicInput] = []
    var headerInputs: [BasicInput] = []
    var rawBody: String = ""
    var loading: Bool = false
    func middleWareFunction() {
        guard !linkInput.isEmpty else {
            isErrorAlert.toggle()
            errorAlertText = "Link Input is empty"
            return
        }

        guard let url = URL(string: linkInput), url.scheme == "https" || url.scheme == "http" else {
            isErrorAlert.toggle()
            errorAlertText = "The URL must start with a proper protocol (https://)"
            return
        }

        paramInputs = paramInputs.map { paramInput in
            var sanitizedInput = paramInput
            sanitizedInput.key = sanitizedInput.key.trimmingCharacters(in: .whitespacesAndNewlines)
            sanitizedInput.value = sanitizedInput.value.trimmingCharacters(in: .whitespacesAndNewlines)
            return sanitizedInput
        }
        fetchData()
    }

    func fetchData() {
        guard var components = URLComponents(string: linkInput) else {
            isErrorAlert.toggle()
            errorAlertText = "The URL entered is invalid"
            return
        }

        for paramInput in paramInputs {
            if paramInput.isChecked, !paramInput.key.isEmpty, !paramInput.value.isEmpty {
                let queryItem = URLQueryItem(name: paramInput.key, value: paramInput.value)
                if components.queryItems == nil {
                    components.queryItems = [queryItem]
                } else {
                    components.queryItems?.append(queryItem)
                }
            }
        }

        guard let url = components.url else {
            return
        }

        let requestHeaders = headers()

        var request = URLRequest(url: url)
        request.httpMethod = requestMethod

        for header in requestHeaders {
            request.headers.add(header)
        }

        if requestMethod == "POST" || requestMethod == "PUT" || requestMethod == "PATCH" {

            let formatted = SwiftJSONFormatter.beautify(rawBody)
            if let jsonDataToVerify = formatted.data(using: String.Encoding.utf8)
            {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                    let serializedData = try JSONSerialization.data(withJSONObject: jsonData, options: [])
                    request.httpBody = serializedData
                    request.headers.add(.contentType("application/json"))
                } catch {
                    isErrorAlert.toggle()
                    errorAlertText = "Error deserializing JSON"
                }
            }
        }

        AF.request(request)
            .validate()
            .responseData { response in
            self.loading = false
            switch response.result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8) {
                    self.responseData = (SwiftJSONFormatter.beautify(jsonString))
                } else {
                    self.responseData = "Invalid response data"
                }
            case .failure(let error):
                self.responseData = "The request could not be fulfilled.\n\n\(error.localizedDescription)"
            }
        }
    }

    private func parameters() -> Parameters? {
        var parameters: Parameters = [:]
        for paramInput in paramInputs {
            if paramInput.isChecked, !paramInput.key.isEmpty, !paramInput.value.isEmpty {
                parameters[paramInput.key] = paramInput.value
            }
        }
        return parameters.isEmpty ? nil : parameters
    }

    private func headers() -> [HTTPHeader] {
        var headers: [HTTPHeader] = []
        for headerInput in headerInputs {
            if headerInput.isChecked, !headerInput.key.isEmpty, !headerInput.value.isEmpty {
                let header = HTTPHeader(name: headerInput.key, value: headerInput.value)
                headers.append(header)
            }
        }
        return headers
    }

    private func bodyParameters() -> [String: Any]? {
        var parameters: [String: Any] = [:]
        for bodyInput in bodyInputs {
            if bodyInput.isChecked, !bodyInput.key.isEmpty, !bodyInput.value.isEmpty {
                if let value = bodyInput.value.data(using: .utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: value, options: [])
                        parameters[bodyInput.key] = json
                    } catch {
                        isErrorAlert.toggle()
                        errorAlertText = "Error parsing JSON from body parameter"
                    }
                }
            }
        }
        return parameters.isEmpty ? nil : parameters
    }
    func checkValidJson(jsonString: String) -> Bool {
        if let data = jsonString.data(using: .utf8) {
            do {
                _ = try JSONSerialization.jsonObject(with: data, options: [])
                return true
            } catch {
                return false
            }
        }
        return false
    }
    func extractKeyValuePairs(from jsonString: String) -> [String: String] {
        guard let jsonData = jsonString.data(using: .utf8) else { return [:] }
        do {
            let jsonObject =
                try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            let keyValuePairs = jsonObject?.compactMapValues { value in
                return "\(value)"
            }
            return keyValuePairs ?? [:]
        } catch {
            return [:]
        }
    }
}
