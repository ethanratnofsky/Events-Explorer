//
//  WebView.swift
//  Events Explorer
//
//  Created by Ethan Ratnofsky on 5/3/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // Parameter(s)
    let url: URL
    
    // Define access to view data manager
    @ObservedObject var viewModel: ContentViewModel
    
    // UI Constructor
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    // UI Updater
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    // FIXME: Don't think this lifecycle management is working properly? isLoading is never changing...
    
    // Lifecycle Manager Constructor?
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    // Define Lifecycle Manager?
    class Coordinator: NSObject, WKNavigationDelegate {
        // Define access to view data manager
        @ObservedObject var viewModel: ContentViewModel
        
        // Constructor
        init(viewModel: ContentViewModel) {
            self.viewModel = viewModel
        }

        // Function called upon initial navigation
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            viewModel.isLoading = true
            viewModel.statusText = "Loading..."
        }

        // Function called upon navigation finish
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            viewModel.isLoading = false
            // TODO: scrape name of first event
            viewModel.statusText = "LOADED!"
        }

        // Function called upon navigation failure
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.isLoading = false
            viewModel.statusText = "Error: \(error.localizedDescription)"
        }
    }
}

