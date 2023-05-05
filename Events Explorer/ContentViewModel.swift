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

    // URL to load in web view
    var url = "https://www.sfstation.com/calendar"
    
    // Scrapes the name of the first event displayed on a webpage loaded in a WKWebView
    func scrapeFirstEventName(webView: WKWebView) {
        // Script to be run in the webview
        let query = "document.querySelector('.event-wrapper span[itemprop=name]').innerText"
        
        webView.evaluateJavaScript(query) { (result, error) in
            // Attempt to cast result as a string and assign it to `eventName` variable
            guard let eventName = result as? String, error == nil else {
                // If there is an error in casting the result as a string or
                // if error is not nil, simply return
                return
            }
            
            // Update the status text that is shown on the view
            self.statusText = eventName
        }
    }
}
