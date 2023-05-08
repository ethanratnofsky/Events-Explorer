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
                
                // Scrape the first event name if the web view loaded calendar of events
                if (webView.url == URL(string: viewModel.url)) {
                    // Scrape event name
                    let queryEventName = "document.querySelector('.event-wrapper .ev_in span[itemprop=name]').innerText"
                    webView.evaluateJavaScript(queryEventName) { (result, error) in
                        // Attempt to cast result as a string and assign it to `eventName` variable
                        guard let eventName = result as? String, error == nil else {
                            // If there is an error in casting the result as a string or
                            // if error is not nil, simply return
                            return
                        }
                        
                        // Update the status text that is shown on the view
                        self.viewModel.statusText = eventName
                    }
                }
            }
    
            // Function called upon navigation failure
            func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
                viewModel.isLoading = false
                viewModel.statusText = "Error: \(error.localizedDescription)"
            }
        }
}
