# Voyager ⛴️

## Introduction

Voyager is a user-friendly macOS application designed for working with API's in an easy-to-interact playground.

Voyager provides a seamless and efficient way to test your APIs and view responses in an in-built interface.

<img width="1193" alt="Screenshot 2023-07-29 at 4 55 39 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/5c7f3008-8ccc-4ea0-9775-d6976982b204">

## Features

- **Native macOS Support**: Voyager is built entirely with Swift and SwiftUI, ensuring a native and optimized user experience. This allows the app to run smoothly and efficiently on macOS, leveraging the platform's capabilities for seamless API testing.

- **User-Friendly Interface**: Voyager offers an intuitive and easy-to-use interface that allows users to quickly set up and execute API requests. The native design integrates seamlessly with macOS, making it familiar to users and enhancing productivity.

- **Request Customization**: Developers can easily customize their API requests with various parameters, headers, authentication methods and body of the request. The responsiveness of the app ensures that users can quickly configure their requests and get instant feedback based on their customizations and changes.

<img width="1186" alt="Screenshot 2023-07-29 at 5 02 18 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/e1ad3575-b1ce-4959-b65a-67517031ba5c">


Read the official [post on ishaanbedi.in/apps/voyager](https://ishaanbedi.in/apps/voyager) to learn more about Voyager.
## Requirements

Voyager runs on macOS 11.0 or later.

To build the app from source, you will need Xcode 12.0 or later installed on your Mac. Also, Voyager depends on some third-party libraries that are managed using Swift Package Manager. Xcode will automatically download and install these dependencies when you build the project for the first time.

## Installation


Voyager is available to download for free from GitHub Releases.

Please visit the [releases page](https://github.com/ishaanbedi/Voyager/releases) to download the latest version of Voyager.

## Getting Started

- **Download and Install**: Download Voyager from the releases page and install it on your Mac.
  Installation is as simple as dragging the app to your Applications folder after opening the `DMG` file.

- **Launch Voyager**: After installation, open Voyager from the Applications folder.

The interface is easy to understand and navigate. The application window is divided into two sections:

- **Query Builder**: This is where you can configure your API requests. You can enter the API URL, choose the request method, add headers, parameters, and authentication if needed.

<img width="1192" alt="Screenshot 2023-07-29 at 5 04 18 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/bc99adab-dba2-4e88-8adf-b8b0807dfbe2">


- **Response Viewer**: The response will be displayed in the application in the response viewer section. If the response is in JSON format, it will be formatted and displayed properly, making it easy to read and understand. If the response is in any other format, it will be displayed as plain text here.

<img width="1102" alt="Screenshot 2023-07-29 at 5 11 36 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/e52edc54-b990-4588-86a3-c38e656d0787">

You can add as many query parameters as a key-value pair as you want. You can also add as many headers as you want. The headers are added as a key-value pair as well. You can also add authentication tokens and bearer tokens to your request in the Header Section, based on the requirements of your API endpoint.


<img width="1185" alt="Screenshot 2023-07-29 at 5 05 12 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/576f9a4e-f695-4bc0-8d27-51ec4224b63f">


Currently, Voyager supports Basic Authentication and Bearer Token Authentication. You can also add a request body to your request. The request body has to be in JSON format so as to be compatible with Voyager. The translated JSON body will be displayed side by side with the request body in the Query Builder section in a Key-Value pair property list format for easy readability. Also, if you type an invalid JSON, Voyager will notify you of the same in the side-by-side JSON body section.

## Usage

### Sending API Requests

To send a request, enter the API URL in the provided field in the Query Builder section. Then, choose the request method from the dropdown menu. You can choose from GET, POST, PUT, DELETE, PATCH, and HEAD. After that, you can add headers, parameters, and authentication if required.

Execute the request by clicking the "Run" button or pressing the "Command + R" keyboard shortcut. The response will be displayed in the Response Viewer section.



<img width="1182" alt="Screenshot 2023-07-29 at 5 05 44 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/15b83730-a5ff-420b-90f5-7422a768d9b6">


<img width="1176" alt="Screenshot 2023-07-29 at 5 06 36 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/9964ba0f-cd2d-4fc5-8b88-5ac5a3838c10">

<img width="1188" alt="Screenshot 2023-07-29 at 5 07 40 PM" src="https://github.com/ishaanbedi/Voyager/assets/39641326/74870ed7-7a2b-4567-8622-e472fcbd58be">


## Acknowledgements

Voyager could not have been possible without the help of the following open-source projects:

- [Alamofire](https://github.com/alamofire/): Under the hood, Voyager uses Alamofire to make API requests and processes the response to update the UI accordingly.

- [SwiftJSONFormatter](https://github.com/luin/SwiftJSONFormatter): Voyager uses SwiftJSONFormatter to format JSON responses in a readable format for the user to understand and debug.

- [CodeEditor](https://github.com/ZeeZide/CodeEditor.git): Voyager uses CodeEditor to display the raw JSON editor and the response editor so as to give a familiar feel to the user of working in an IDE. This also allows the user to easily edit the JSON body and see the changes in real-time in a highlighted format.


## Some Questions

### Why should I use Voyager?

Voyager is a simple and easy-to-use API testing tool that allows you to quickly test your API endpoints and view responses in a native macOS application. It is designed to be user-friendly and intuitive, making it easy for developers to test their APIs and debug issues.

### Is this an alternative to Postman/Insomnia?

Absolutely not. While Voyager is a great tool for testing APIs, it is not a replacement for Postman or Insomnia. I built Voyager to be a simple and easy-to-use tool for API testing that can be used instantly and is super lightweight, fast, and just gets the work done while building my apps. While Postman/Insomnia provides 10x or maybe 100x more features as compared to Voyager, it doesn't aim to compete with them in terms of complexity and extensibility since this tool is meant to be used for quick API testing and debugging.

### Can I run Voyager on an operating system other than macOS?

Voyager is built with tools and technologies that are exclusive to macOS, so it cannot run on any other operating system.

### Can I run Voyager on an older version of macOS?

Voyager is built with Swift and SwiftUI, and some of the features used in the app depend on external libraries that support macOS 11.0 or later. Therefore, Voyager cannot run on older versions of macOS.
However, you can build the app from the source and run it on older versions of macOS while downgrading some features while building the app and customizing the code yourself as per your needs.

### Do I need to have Xcode installed to use Voyager?

No, you do not need to have Xcode installed to use Voyager. You can download the app from the releases page and install it on your Mac. However, if you want to build the app from source, you will need to have Xcode installed on your Mac.

## Bug Reports and Feedback

To report bugs or request new features, please open an issue on GitHub.

If you encounter any vulnerabilities, please reach out to me directly at [hi@ishaanbedi.in](hi@ishaanbedi.in) if it involves sensitive information or security concerns.

## License

Voyager is distributed under the MIT License.

See the [LICENSE](license) file for more information.
