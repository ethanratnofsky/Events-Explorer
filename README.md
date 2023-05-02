# Events Explorer

## Objectives

1. Figure out how to build a simple SwiftUI app based on the MVVM pattern.
2. Feature wise, figure out how to connect between iOS native app and in-app browser.

## Design

<img src="/events-explorer-desgin.png" alt="Events Explorer Design" />
The Figma design document is linked [here](https://www.figma.com/file/zIZxhjtu7pbzavfpaohiT7/Events-Explorer?node-id=0%3A1&t=Lj8s59uK3OTjf9fg-1).

## How It Works

1. The app consists of three parts:
   a. Static title (“Events Explorer”)
   b. In-app browser view
   c. Status text (“Loading…”)
2. Once the app is loaded,
   a. The in-app browser view starts to load the webview (“https://www.sfstation.com/calendar”)
   b. The status text shows “Loading…”
3. Once the website is loaded, the in-app browser view should show the webview as it is.
4. The app tries to read the DOM tree and find the first event name.
5. Once it finds it out, the status text should update to the name.
6. When a user clicks the updated text in the app, the app tries to click the event name in the in-app browser.

## Requirements

1. The app should be made using SwiftUI
2. ViewModel (in SwiftUI MVVM pattern) is in charge of understanding the DOM tree and finding the first event name.
3. The view layer just refers to this ViewModel layer using @State/@Published.

## Deliverables

1. Demo video
2. App project files

## Useful Information

1. [How to display Web Page Using WKWebView](https://www.appcoda.com/swiftui-wkwebview/)
2. [How to interact with WKWebView in Swift app](https://medium.com/@mushtaque87/webkit-4bd5cf3dc08)
3. [How to find a DOM element](https://www.w3schools.com/jsref/met_document_queryselector.asp)
4. [How to click a DOM element](https://www.w3schools.com/jsref/met_html_click.asp)
