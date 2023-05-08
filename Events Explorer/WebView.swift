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
    let url: String
    
    // Define access to view data manager
    @ObservedObject var viewModel: ContentViewModel
    
    // UI Constructor: creates WKWebView and loads request
    func makeUIView(context: Context) -> WKWebView {
        let url = URL(string: self.url)!
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        // Initialize webView in view model (necessary for evaluating JS)
//        viewModel.webView = webView
        
        return webView
    }
    
    // UI Updater
    func updateUIView(_ webView: WKWebView, context: Context) {
        // Scrape event link and click it
        if (viewModel.isEventClicked) {
            let clickEvent = "document.querySelector('.event-wrapper .ev_in a').click()"
            webView.evaluateJavaScript(clickEvent)
        }
    }
    
    
    
    // Lifecycle Manager Constructor?
    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel)
    }
}

