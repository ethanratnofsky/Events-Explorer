//
//  WebViewCoordinator.swift
//  Events Explorer
//
//  Created by Ethan Ratnofsky on 5/5/23.
//

import Foundation
import SwiftUI
import WebKit

extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
            // Define access to view data manager
            @ObservedObject private var viewModel: ContentViewModel
            
            // Constructor
            init(_ viewModel: ContentViewModel) {
                self.viewModel = viewModel
            }
    
            // Function called before navigation
            func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
                // TODO: Anything necessary here?
            }
    
            // Function called upon navigation finish
            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                viewModel.isLoading = false
                
                // Scrape the first event if the web view loaded calendar of events
                if (webView.url == URL(string: viewModel.url)) {
                    viewModel.scrapeFirstEvent(webView: webView)
                }
            }
    
            // Function called upon navigation failure
            func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
                viewModel.isLoading = false
                viewModel.statusText = "Error: \(error.localizedDescription)"
            }
        }
}
