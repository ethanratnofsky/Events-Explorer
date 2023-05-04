//
//  ContentViewModel.swift
//  Events Explorer
//
//  Created by Ethan Ratnofsky on 5/3/23.
//

import Foundation
import WebKit

class ContentViewModel: NSObject, ObservableObject {
    // State
    @Published var isLoading = true
    @Published var statusText = "Loading..."
    @Published var webView: WebView?

    // URL to load in web view
    let url = "https://www.sfstation.com/calendar"
    
    // Constructor
    override init() {
        super.init()
        self.webView = self.createWebView()
    }

    // Instantiates WebView
    private func createWebView() -> WebView {
        return WebView(url: URL(string: self.url)!, viewModel: self)
    }
}
